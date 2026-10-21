#!/usr/bin/env python3
"""Independent, deliberately bounded audit of the frozen 21-group input set.

No executor reports/VC decisions are read. Arithmetic and single-cell programs
are interpreted here; aggregate/call cases use the explicit reviewed derivations
below. Unsupported syntax or changed source/bind hashes abort instead of guessing.
This is an oracle audit, not a C interpreter or a new formal verification result.
"""

from __future__ import annotations
import ast
import collections
import csv
import hashlib
import json
import operator
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
OUT = ROOT / "benchmark/results/expectation-audit-20261021"
MIN, MAX, MOD = -(2**31), 2**31 - 1, 2**32
SIMPLE = {
    "abs",
    "add",
    "example_let",
    "quadruple",
    "read",
    "incr",
    "zero",
    "slf3_basic_inplace_double",
    "abs_mem",
    "slf_quadruple_mem",
    "const_example",
}


class UnsafeAccess(Exception):
    pass


class SignedOverflow(Exception):
    pass


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def checked(ref):
    p = ROOT / ref["path"]
    if digest(p) != ref["sha256"]:
        raise ValueError("Stale reviewed source/input: " + ref["path"])
    return p


def span(text, start, opening="(", closing=")"):
    assert text[start] == opening
    depth = 1
    i = start + 1
    while depth:
        if text[i] == opening:
            depth += 1
        if text[i] == closing:
            depth -= 1
        i += 1
    return text[start + 1 : i - 1], i


def split_args(text):
    parts, depth, start = [], 0, 0
    for i, c in enumerate(text):
        if c == "(":
            depth += 1
        if c == ")":
            depth -= 1
        if c == "," and depth == 0:
            parts.append(text[start:i].strip())
            start = i + 1
    return parts + [text[start:].strip()]


def replace_call(text, name, fn):
    pattern = re.compile(r"\b" + re.escape(name) + r"\s*\(")
    while m := pattern.search(text):
        inside, end = span(text, m.end() - 1)
        text = text[: m.start()] + str(fn(split_args(inside))) + text[end:]
    return text


def function(source, name):
    # Strip line comments first: commented-out CN assertions are not executable.
    source = re.sub(r"//[^\n]*", "", source)
    pattern = (
        r"((?:unsigned\s+)?(?:int|void))\s+"
        + re.escape(name)
        + r"\s*\(([^{};]*)\)\s*(/\*@.*?\*/)?\s*\{"
    )
    m = re.search(pattern, source, re.S)
    if not m:
        raise ValueError("Unsupported/missing function " + name)
    body, _ = span(source, m.end() - 1, "{", "}")
    body = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
    return {
        "return_type": m[1],
        "parameters": m[2],
        "contract": m[3] or "",
        "body": body,
    }


def expression(text, env, unsigned=None):
    """unsigned=None: mathematical specification; otherwise checked 32-bit C."""
    text = text.replace("&&", " and ").replace("||", " or ").strip()

    def bound(v):
        if unsigned is None:
            return v
        if unsigned:
            return v % MOD
        if not MIN <= v <= MAX:
            raise SignedOverflow(str(v))
        return v

    binary = {
        ast.Add: operator.add,
        ast.Sub: operator.sub,
        ast.Mult: operator.mul,
        ast.Mod: operator.mod,
    }
    compare = {
        ast.Eq: operator.eq,
        ast.NotEq: operator.ne,
        ast.Lt: operator.lt,
        ast.LtE: operator.le,
        ast.Gt: operator.gt,
        ast.GtE: operator.ge,
    }

    def visit(n):
        if isinstance(n, ast.Constant) and isinstance(n.value, (int, bool)):
            return n.value
        if isinstance(n, ast.Name):
            if n.id in {"True", "true"}:
                return True
            if n.id in {"False", "false"}:
                return False
            v = env[n.id]
            if callable(v):
                return v()
            return v
        if isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.USub):
            return bound(-visit(n.operand))
        if isinstance(n, ast.BinOp) and type(n.op) in binary:
            return bound(binary[type(n.op)](visit(n.left), visit(n.right)))
        if isinstance(n, ast.BoolOp):
            return (all if isinstance(n.op, ast.And) else any)(
                bool(visit(v)) for v in n.values
            )
        if isinstance(n, ast.Compare):
            left = visit(n.left)
            for op, right in zip(n.ops, n.comparators):
                value = visit(right)
                if not compare[type(op)](left, value):
                    return False
                left = value
            return True
        raise ValueError("Unsupported expression " + ast.dump(n))

    return visit(ast.parse(text, mode="eval").body)


def simple_derive(src, name, binding):
    f = function(src, name)
    req, post = re.search(
        r"Require\s+(.*?)\s+Ensure\s+(.*?)\s*\*/", f["contract"], re.S
    ).groups()
    env = dict(binding["args"]) | dict(binding["values"])
    uint = "unsigned" in f["parameters"]
    if any(
        not (0 <= v < MOD if uint else MIN <= v <= MAX)
        for v in binding["values"].values()
    ):
        raise ValueError("Out-of-range input")
    pre_init = re.search(r"(?<!undef_)\bdata_at\(", req) is not None
    owned = pre_init or "undef_data_at(" in req.replace(" ", "")
    cell = next(iter(binding["values"].values()), None) if pre_init else None
    initialized = pre_init
    pre = replace_call(req, "undef_data_at", lambda a: True)
    pre = replace_call(pre, "data_at", lambda a: True).replace("emp", "True")
    if not expression(pre, env):
        raise ValueError("Input does not satisfy precondition")
    if owned and (binding["args"]["p"] <= 0 or binding["args"]["p"] % 4):
        raise ValueError("Invalid owned-cell address")
    trace = []

    def load():
        if not owned:
            raise UnsafeAccess("read without ownership (emp precondition)")
        if not initialized:
            raise UnsafeAccess("read from uninitialized owned storage")
        return cell

    env["__cell"] = load

    def cexpr(e):
        return expression(e.replace("*p", "__cell"), env, uint)

    def execute(body):
        nonlocal cell, initialized
        while body.strip():
            body = body.lstrip()
            if body.startswith("if"):
                start = body.index("(")
                cond, end = span(body, start)
                p = end
                while body[p].isspace():
                    p += 1
                yes, end = span(body, p, "{", "}")
                tail = body[end:].lstrip()
                if not tail.startswith("else"):
                    raise ValueError("Expected explicit else")
                tail = tail[4:].lstrip()
                no, end2 = span(tail, 0, "{", "}")
                branch = bool(cexpr(cond))
                trace.append({"condition": cond, "value": branch})
                returned, value = execute(yes if branch else no)
                if returned:
                    return True, value
                body = tail[end2:]
                continue
            stmt, sep, body = body.partition(";")
            if not sep:
                raise ValueError("Unterminated C statement")
            stmt = stmt.strip()
            if stmt.startswith("return "):
                return True, cexpr(stmt[7:])
            if not stmt:
                continue
            m = re.fullmatch(
                r"(?:(?:unsigned\s+)?int\s+)?(\w+|\*p)\s*=\s*(.*)", stmt, re.S
            )
            if not m:
                raise ValueError("Unsupported C statement " + stmt)
            value = cexpr(m[2])
            if m[1] == "*p":
                if not owned:
                    raise UnsafeAccess("write without ownership (emp precondition)")
                cell = value
                initialized = True
            else:
                env[m[1]] = value
            trace.append({"assignment": m[1], "value": value})
        return False, None

    witness = {
        "precondition_valid": True,
        "method": "independent checked arithmetic/single-cell interpreter",
        "input": binding,
        "trace": trace,
    }
    try:
        _, ret = execute(f["body"])
    except UnsafeAccess as e:
        return {"inline": "ERROR", "modular": "ERROR", "fulminate": "FAIL"}, witness | {
            "reason": str(e)
        }
    except SignedOverflow as e:
        return {"inline": "FAIL", "modular": "FAIL", "fulminate": "FAIL"}, witness | {
            "reason": "signed C overflow",
            "overflow_value": str(e),
        }
    penv = dict(binding["args"]) | dict(binding["values"]) | {"__return": ret}
    existential = re.match(r"\s*exists\s+(\w+)\s*,", post)
    if existential:
        post = post[existential.end() :]

    def cell_post(args):
        if not owned or not initialized:
            return False
        if existential and args[2] == existential[1]:
            return True
        return cell == expression(args[2], penv)

    pp = replace_call(post, "data_at", cell_post).replace("emp", str(not owned))
    ok = bool(expression(pp, penv))
    status = "PASS" if ok else "FAIL"
    return dict.fromkeys(["inline", "modular", "fulminate"], status), witness | {
        "reason": "postcondition holds"
        if ok
        else "postcondition false (including exact ownership)",
        "return_value": ret,
        "final_cell": cell,
        "owned": owned,
        "initialized": initialized,
        "postcondition_instantiated": pp,
    }


# These are reviewed derivations, not automatic proofs. They include callees and
# intermediate assertions; all source and binding hashes are checked before use.
NOTES = {
    "abs_mem_struct": "abs_mem requires MIN<y, returns abs(y), and preserves its cell. Frame p.x across the call; both fields survive.",
    "add_read": "Two distinct uint cells are read and retained; unsigned addition is modulo 2^32.",
    "add_two_array": "Both distinct indices are in bounds; reads retain the whole array and return their unsigned modular sum.",
    "incr_first": "The strong increment contract updates only p by one modulo 2^32; q is framed. Review includes incr_first_frame and its callee.",
    "init_point": "Disjoint uninitialized x/y fields each receive 0 via zero; no uninitialized value is read.",
    "swap": "Read both distinct uint cells, then write old q to p and old p to q.",
    "swap_array": "Save old l[i], write old l[j] to i, then saved old l[i] to j; i!=j. This equals the nested replace_Znth post.",
    "transfer": "Separate case adds modulo 2^32 and clears q. Aliased case owns one cell, reads it twice and finally clears that same cell.",
    "transpose": "Swap two disjoint fields. transpose2 uses the strong swap contract; the false assertion in original transpose.broken is commented out.",
    "array_load": "read returns the selected element without writes. Clients check [0,1,2]. Strong modular contracts retain return/content information; the weak contract does not.",
}


def aggregate_derive(group, src, name, b):
    a, v = b["args"], b["values"]
    unsigned = "unsigned" in src
    for x in v.values():
        vals = x if isinstance(x, list) else [x]
        if any(not (0 <= z < MOD if unsigned else MIN <= z <= MAX) for z in vals):
            raise ValueError("Out-of-range aggregate input")
    for key in ["p", "q", "a"]:
        if key in a and (a[key] <= 0 or a[key] % 4):
            raise ValueError("Invalid owned address")
    w = {
        "precondition_valid": True,
        "method": "reviewed aggregate/callee-contract derivation",
        "input": b,
        "reason": NOTES[group],
    }
    states = dict.fromkeys(["inline", "modular", "fulminate"], "PASS")
    if group == "abs_mem_struct":
        assert MIN < v["y"]
        w.update(return_value=abs(v["y"]), final_fields=v)
    elif group in {"add_read", "swap", "incr_first", "transfer"}:
        alias = a["p"] == a["q"]
        if group != "transfer":
            assert not alias
        if group == "transfer" and "p == q" in src:
            assert alias
            w["final_cells"] = {str(a["p"]): 0}
        else:
            assert not alias
            x, y = v["v"], v["w"]
            if group == "add_read":
                w.update(return_value=(x + y) % MOD, final_cells=v)
            if group == "swap":
                w["final_cells"] = {str(a["p"]): y, str(a["q"]): x}
            if group == "incr_first":
                w["final_cells"] = {str(a["p"]): (x + 1) % MOD, str(a["q"]): y}
            if group == "transfer":
                w["final_cells"] = {str(a["p"]): (x + y) % MOD, str(a["q"]): 0}
    elif group in {"add_two_array", "swap_array"} or (
        group == "array_load" and name == "read"
    ):
        values = v["l"]
        i = a["i"]
        assert a["n"] == len(values) and 0 <= i < len(values)
        if group == "array_load":
            w.update(return_value=values[i], final_array=values)
        else:
            j = a["j"]
            assert 0 <= j < len(values) and i != j
            if group == "add_two_array":
                w.update(return_value=(values[i] + values[j]) % MOD, final_array=values)
            else:
                result = values.copy()
                result[i], result[j] = values[j], values[i]
                w["final_array"] = result
    elif group == "init_point":
        w["final_fields"] = {"x": 0, "y": 0}
    elif group == "transpose":
        w["final_fields"] = {"x": v["y"], "y": v["x"]}
    elif group == "array_load":
        assert name in {"main", "verify_main"}
        assert all(s in src for s in ["zero == 0", "one == 1", "two == 2"])
        contract = function(src, "read")["contract"]
        w.update(
            return_value=0, concrete_read_values=[0, 1, 2], callee_contract=contract
        )
        if "__return ==" not in contract:
            states["modular"] = "FAIL"
            w["modular_counterexample"] = {
                "array": [0, 1, 2],
                "first_call_return": 1,
                "explanation": "Allowed by ownership-only post; contradicts zero==0. This is a contract-state counterexample, not an execution of the read body.",
                "kernel_evidence": "benchmark/results/array_load/20261021-local-counterexample/attempt-2-check-2/receipt.json",
            }
        if name == "verify_main":
            assert "cons(0,cons(1,cons(2,nil)))" in function(src, name)["contract"]
            if "a0" in v:
                assert a["a"] == v["a0"]
    else:
        raise ValueError("Missing aggregate derivation " + group)
    return states, w


def check_cn_inputs(t, binding):
    """Check the emitted C harness inputs, including alias relations, against binds."""
    body = function(checked(t["cn_harness"]).read_text(), "main")["body"]
    g, name = t["group"], t["function"]
    a, v = binding["args"], binding["values"]

    def number(text):
        return expression(re.sub(r"(?<=\d)[uUlL]+\b", "", text.strip()), {})

    def call_args(fn):
        m = re.search(r"\b" + re.escape(fn) + r"\s*\(", body)
        if not m:
            raise ValueError("CN target not called: " + fn)
        return split_args(span(body, m.end() - 1)[0])

    if g in {"abs", "add", "example_let", "quadruple", "const_example"}:
        args = [number(x) for x in call_args(name)]
        assert args == list(a.values()), (t["case"], args, a)
    elif g in {"abs_mem_struct", "transpose"}:
        fields = {
            m[1]: number(m[2]) for m in re.finditer(r"\.([xy])\s*=\s*([^,}]+)", body)
        }
        assert fields == v, (t["case"], fields, v)
        assert call_args(name)[0].startswith("&")
    elif g in {"array_load", "swap_array", "add_two_array"}:
        if g == "array_load" and name != "read":
            assert re.search(r"\[3\]\s*=\s*\{\s*0\s*,\s*1\s*,\s*2\s*\}", body)
            args = call_args("array_load_read")
            assert [number(z) for z in args[1:]] == [3, 0]
        else:
            m = re.search(r"\[(\d+)\]\s*=\s*\{([^}]+)\}", body)
            assert m, t["cn_harness"]
            cells = [number(x) for x in m[2].split(",")]
            assert cells == v["l"] and int(m[1]) == a["n"]
            args = call_args("array_load_read" if g == "array_load" else name)
            expected = [a[k] for k in ["n", "i", "j"] if k in a]
            assert [number(x) for x in args[1:]] == expected
    elif g in {"add_read", "swap", "incr_first", "transfer"}:
        variables = {
            m[1]: number(m[2])
            for m in re.finditer(r"unsigned\s+int\s+(\w+)\s*=\s*([^;]+);", body)
        }
        args = call_args(name)
        names = [x.strip().lstrip("&") for x in args]
        assert variables[names[0]] == v["v"]
        assert (names[0] == names[1]) == (a["p"] == a["q"])
        if "w" in v:
            assert variables[names[1]] == v["w"]
    elif g in {"init_point", "zero"} and "cells[" in body:
        args = call_args(name)
        m = re.fullmatch(r"&cells\[(\d+)\]", args[0])
        assert m
        index = int(m[1])
        size = 8 if g == "init_point" else 4
        assert a["p"] == 4096 + index * size
        assignment = re.search(r"cells\[\d+\]\s*=\s*([^;]+);", body)
        if v:
            assert assignment and number(assignment[1]) == next(iter(v.values()))
        else:
            assert not assignment
    else:
        args = call_args(name)
        null = bool(re.fullmatch(r"\(int\s*\*\)\s*0", args[0]))
        assert null == (a["p"] == 0)
        init = re.search(r"(?:unsigned\s+)?int\s+cell\s*=\s*([^;]+);", body)
        if v:
            assert init and number(init[1]) == next(iter(v.values()))
        elif init and isinstance(t["initial"], int):
            assert number(init[1]) == t["initial"]
    return {"verified": True, "harness": t["cn_harness"], "entry_body": body.strip()}


def c_bodies(src):
    text = re.sub(r"//[^\n]*|/\*.*?\*/", "", src, flags=re.S)
    result = {}
    for m in re.finditer(r"\b(\w+)\s*\([^;{}]*\)\s*\{", text):
        if m[1] in {"if", "while", "for", "switch"}:
            continue
        body, _ = span(text, m.end() - 1, "{", "}")
        result[m[1].replace("array_load_read", "read")] = re.sub(
            r"\s+", "", body
        ).replace("array_load_read", "read")
    return result


def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def run():
    inputs = json.loads((OUT / "inputs.json").read_text())["cases"]
    groups = collections.defaultdict(list)
    pairs = {}
    for t in inputs:
        src = checked(t["qcp_source"]).read_text()
        cn = checked(t["cn_source"]).read_text()
        bindings = json.loads(checked(t["binds"]).read_text())
        b = next(b for b in bindings if b["id"] == t["case"])
        derived, w = (
            simple_derive(src, t["function"], b)
            if t["group"] in SIMPLE
            else aggregate_derive(t["group"], src, t["function"], b)
        )
        w["cn_input_alignment"] = check_cn_inputs(t, b)
        matched = {
            k: derived[k] == t["recorded"][k]
            for k in ["inline", "modular", "fulminate"]
        }
        non_equiv = (
            t["group"] == "array_load"
            and t["variant"] == "cn_original:array_load.broken"
            and "__return ==" in function(src, "read")["contract"]
        )
        key = (t["group"], t["variant"], t["paired_qcp_variant"])
        if key not in pairs:
            cb, qb = c_bodies(cn), c_bodies(src)
            diffs = {
                n: {"cn": cb.get(n), "qcp": body}
                for n, body in qb.items()
                if cb.get(n) != body
            }
            pairs[key] = {
                "group": t["group"],
                "cn_variant": t["variant"],
                "qcp_variant": t["paired_qcp_variant"],
                "cn_source": t["cn_source"],
                "qcp_source": t["qcp_source"],
                "qcp_functions": {n: function(src, n) for n in qb},
                "cn_specifications": re.findall(r"/\*@.*?\*/", cn, re.S),
                "c_body_differences": diffs,
                "alignment": "QCP_HELPER_STRONGER_THAN_CN"
                if non_equiv
                else "REVIEWED_TARGET_PAIR",
                "scope_note": "Comparison concerns each language contract at this target. It is not a claim of arbitrary whole-file contract equivalence.",
                "manual_derivation": NOTES.get(
                    t["group"], "Bounded arithmetic/cell model; see each case trace."
                ),
                "cases": [],
            }
        pairs[key]["cases"].append(t["case"])
        groups[t["group"]].append(
            t
            | {
                "derived": derived,
                "matches_recorded": matched,
                "witness": w,
                "same_contract_comparison_excluded": non_equiv,
            }
        )
    summary = {
        "schema": "independent-expectation-audit/v1",
        "inputs_sha256": digest(OUT / "inputs.json"),
        "oracle_tool_sha256": digest(Path(__file__)),
        "groups": len(groups),
        "case_pairs": len(inputs),
        "cn_qcp_pairings": len(pairs),
        "function_configurations": len(
            {
                (t["group"], t["variant"], t["paired_qcp_variant"], t["function"])
                for t in inputs
            }
        ),
        "case_strategy_expectations_checked": len(inputs) * 2,
        "fulminate_expectations_checked": len(inputs),
        "mismatches": sum(
            not all(t["matches_recorded"].values())
            for rs in groups.values()
            for t in rs
        ),
        "non_equivalent_contract_cases": sum(
            t["same_contract_comparison_excluded"] for rs in groups.values() for t in rs
        ),
        "legacy_fulminate_ERROR_labels": sum(
            t["fulminate_legacy_label"] for t in inputs
        ),
        "method": "Independent source/input oracle audit; no native execution results or solver decisions consumed. Reviewed aggregate derivations are not new formal proofs.",
        "groups_summary": [],
    }
    for group, rs in sorted(groups.items()):
        pp = [p for p in pairs.values() if p["group"] == group]
        scopepath = ROOT / f"benchmark/programs/{group}/evaluation-plan.json"
        if scopepath.exists():
            plan = json.loads(scopepath.read_text())
            scope = {
                k: plan[k]
                for k in ["primary_cn_variant", "primary_qcp_variant", "function"]
                if k in plan
            }
        else:
            old = json.loads(
                (ROOT / f"benchmark/results/{group}/result-cost.json").read_text()
            )
            scope = {
                "primary_variant": old.get("primary_variant"),
                "source": f"benchmark/results/{group}/result-cost.json",
            }
        gsum = {
            "group": group,
            "case_pairs": len(rs),
            "pairings": len(pp),
            "function_configurations": len(
                {(t["variant"], t["paired_qcp_variant"], t["function"]) for t in rs}
            ),
            "derived_counts": {
                k: dict(collections.Counter(t["derived"][k] for t in rs))
                for k in ["inline", "modular", "fulminate"]
            },
            "mismatches": sum(not all(t["matches_recorded"].values()) for t in rs),
            "non_equivalent_contract_cases": sum(
                t["same_contract_comparison_excluded"] for t in rs
            ),
            "primary_verification_scope": scope,
            "verification_caveat": "CN/QCP full verification is restricted to the selected primary target/module. This audit neither reruns it nor extends certificates to every variant/client.",
        }
        summary["groups_summary"].append(gsum)
        folder = OUT / "groups" / group
        save(folder / "audit.json", {"summary": gsum, "pairs": pp, "cases": rs})
        with (folder / "cases.csv").open("w", newline="") as f:
            wr = csv.writer(f, lineterminator="\n")
            wr.writerow(
                [
                    "variant",
                    "qcp_variant",
                    "case",
                    "function",
                    "inline",
                    "modular",
                    "fulminate",
                    "all_match",
                    "same_contract_comparison_excluded",
                    "reason",
                ]
            )
            for t in rs:
                wr.writerow(
                    [
                        t["variant"],
                        t["paired_qcp_variant"],
                        t["case"],
                        t["function"],
                        *t["derived"].values(),
                        all(t["matches_recorded"].values()),
                        t["same_contract_comparison_excluded"],
                        t["witness"]["reason"],
                    ]
                )
        lines = [
            f"# {group} 预期审查",
            "",
            f"审查 {len(rs)} 对输入，{len(pp)} 组 CN/QCP 配对；预期不一致 {gsum['mismatches']}。",
            "",
            "由源码、规约和绑定推导；没有用工具 PASS/FAIL/UNKNOWN 结果作为预期依据。完整源码摘要、哈希、逐例数值/堆见 audit.json。",
            "",
            "| CN 变体 | 用例 | inline | modular | Fulminate |",
            "|---|---|---|---|---|",
        ]
        lines += [
            f"| {t['variant']} | {t['case']} | {t['derived']['inline']} | {t['derived']['modular']} | {t['derived']['fulminate']} |"
            for t in rs
        ]
        lines += ["", gsum["verification_caveat"]]
        if gsum["non_equivalent_contract_cases"]:
            lines += [
                "",
                "其中 42 对输入采用增强的 QCP read 规约，排除在同规约跨工具比较之外。",
            ]
        (folder / "audit.md").write_text("\n".join(lines) + "\n")
    save(OUT / "summary.json", summary)
    lines = [
        "# 前 21 组预期审查（2026-10-21）",
        "",
        f"900 对输入、{len(pairs)} 组 CN/QCP 配对、{summary['function_configurations']} 个目标配置；检查 1800 项策略预期及 900 项 Fulminate 预期。",
        "",
        f"新发现的状态预期错误：{summary['mismatches']}。沿用已修正的 translation12：inline PASS，modular FAIL。",
        "",
        "| 组 | 输入对 | inline P/F/E | modular P/F/E | 不一致 |",
        "|---|---:|---|---|---:|",
    ]
    for g in summary["groups_summary"]:

        def counts(k):
            return "/".join(
                str(g["derived_counts"][k].get(s, 0)) for s in ["PASS", "FAIL", "ERROR"]
            )

        lines.append(
            f"| [{g['group']}](groups/{g['group']}/audit.md) | {g['case_pairs']} | {counts('inline')} | {counts('modular')} | {g['mismatches']} |"
        )
    lines += [
        "",
        "## 影响实验解读的两项限制",
        "",
        "- array_load 的 translation5/6/7/8/9/11 共 42 对输入使用比 CN 更强的 QCP helper 规约。有限测试预期成立，但不得作为“同规约 CN/QCP 对照”，也不能把 QCP 的主程序证明套给 CN 弱规约客户端。",
        "- read 的 7 个旧 Fulminate 预期标签 ERROR 表示预期运行拒绝，旧分类器使用 RUNTIME_FAILURE。这不是 teSpec ERROR。此审查统一记为 Fulminate FAIL，并保留 fulminate_raw=ERROR 和原始报告；未改写历史测量。",
        "",
        "## 判定依据",
        "",
        "- 算术按 32 位 C 逐中间步骤检查：有符号溢出为 FAIL，无符号运算模 2^32；规约里的数学表达式不做隐式回绕。",
        "- 负变体也可能在 0、相等值或模回绕等特定输入通过；逐输入判定，不按变体名称一刀切。",
        "- emp 是合法空堆前提，但不给读写权限。缺权读写及读未初始化对象的 23 例为预期 teSpec ERROR；只认可相应访问错误，不泛化为任意 ERROR。",
        "- 后置 emp 丢失仍持有的外部单元，按本实验精确空间语义为 FAIL。弱 exists 后置本身可以合法；不能因为弱就把 helper 判负。",
        "- 对调用/聚合对象逐一审查被调函数规约、分离、别名和内部 assertion；translation12 的 modular 反例允许返回 1 而首断言要求 0。",
        "- CN/QCP 主程序验证范围保持原有选定目标；本次审查不声称重新形式化验证所有变体。",
        "",
        "重放：`python3 tools/benchmark/audit_group_expectations.py`。源码或绑定哈希变化会拒绝重放，需重新人工审查。",
    ]
    (OUT / "index.md").write_text("\n".join(lines) + "\n")
    print(
        json.dumps(
            {k: v for k, v in summary.items() if k != "groups_summary"},
            ensure_ascii=False,
            indent=2,
        )
    )
    if summary["mismatches"]:
        raise SystemExit(1)


if __name__ == "__main__":
    run()
