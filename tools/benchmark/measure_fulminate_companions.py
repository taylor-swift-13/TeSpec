#!/usr/bin/env python3
"""Measure contract-matched Fulminate companions and audit the frozen comparison exclusions."""

import argparse
import hashlib
import json
import re
from pathlib import Path

from cn_toolchain import CN, ROOT, installed_identity
from replay_dll_remove_fulminate import COMPILER, SHARED, UPSTREAM, executable, measured, sha

PROGRAMS = ROOT / "benchmark/programs"
RESULTS = ROOT / "benchmark/results"


def load(path):
    return json.loads(path.read_bytes())


def text_hash(text):
    return hashlib.sha256(text.encode()).hexdigest()


def relative(path):
    return str(path.relative_to(ROOT))


def clean_c(source):
    return re.findall(r"[a-zA-Z_]\w*|\d+|[^\s]", re.sub(r"/\*[\s\S]*?\*/|//[^\n]*", "", source))


def sources(group):
    return {
        v["id"]: load(ROOT / v["manifest"])["files"]
        for v in load(PROGRAMS / group / "manifest.json")["variants"]
    }


def locked_math(text):
    # CN v5.2 uses mathematical integers for the unbounded specification language.
    def block(m):
        s = re.sub(r"\b(\d+)[iu]32\b", r"\1", m.group())
        s = s.replace("function (i32)", "function (integer)")
        return s

    return re.sub(r"/\*@[\s\S]*?\*/", block, text)


def dll_subject(group, original, primary, case):
    if clean_c(original) != clean_c(primary):
        raise ValueError("annotated and unannotated DLL C bodies differ")
    contract = re.search(r"/\*@ requires[\s\S]*?@\*/", primary)[0]
    if group == "dll_add":
        # Dll(0,nil,0,nil) is explicitly permitted by DLLSupplement.v.
        start = contract.index("is_null(n) ?")
        cases = contract[start : contract.index(";", start)]
        contract = (
            contract[:start]
            + "((is_null(n) && element == 0 && is_null(return)) || (("
            + cases
            + ") && Node(After).data == element));\n@*/"
        )
    else:
        extra = "(is_null(del.prev) && is_null(del.next)) ? is_null(ret.node) : (!is_null(del.next) ? ptr_eq(ret.node,del.next) : ptr_eq(ret.node,del.prev));"
        contract = contract.replace("@*/", extra + "\n@*/")
    head, body = original.split("{", 1)
    if "/*@" in head:
        raise ValueError("expected unannotated function declaration")
    return head + contract + "\n{" + body + "\nint main(void) { " + case["cn_body"] + " return 0; }\n"


def spec(source, target):
    match = re.search(r"\b" + re.escape(target) + r"\s*\([^)]*\)\s*(/\*@[\s\S]*?\*/)", source)
    if not match:
        raise ValueError(f"missing declared QCP target contract for {target}")
    return match[1]


def main_subject(original, case, qcp_contract, strong_helper=None):
    head = re.split(r"\bint\s+main\s*\(", original, maxsplit=1)[0]
    if strong_helper is not None:
        head = strong_helper.split("int main(", 1)[0]
    # Ordinary target function forces the checked exit through the runtime's normal
    # function return path; C specifies implicit return 0 only for the original main.
    if qcp_contract == "/*@ Require emp Ensure __return == 0 && emp */":
        cn_contract = "/*@ requires true; ensures return == 0; @*/"
    elif qcp_contract == "/*@ Require emp Ensure emp */":
        cn_contract = "/*@ requires true; ensures true; @*/"
    else:
        raise ValueError(f"unsupported main contract {qcp_contract}")
    body = case["cn_body"]
    return locked_math(
        head
        + "\nint comparison_client(void) "
        + cn_contract
        + " { "
        + body
        + "\nreturn 0; }\nint main(void) { return comparison_client(); }\n"
    )


def make_subject(group, pair, case, files, plan):
    cn = ROOT / files[pair["cn_variant"]]["cn"]["path"]
    qcp = ROOT / files[pair["qcp_variant"]]["qcp"]["path"]
    original = cn.read_text()
    target = pair["function"]
    qcontract = spec(qcp.read_text(), target)
    if group in ("dll_add", "dll_remove"):
        primary = ROOT / files[plan["primary_cn_variant"]]["cn"]["path"]
        return dll_subject(group, original, primary.read_text(), case), target
    if target == "bad_free":
        if qcontract != "/*@ Require emp Ensure emp */":
            raise ValueError(qcontract)
        head = re.split(r"\bint\s+main\s*\(", original, maxsplit=1)[0]
        subject = re.sub(
            r"(void\s+bad_free\s*\([^)]+\)\s*)/\*@\s*trusted;\s*@\*/",
            r"\1/*@ requires true; ensures true; @*/",
            head,
        )
        if subject == head:
            raise ValueError("failed to attach bad_free contract")
        return locked_math(subject + "\nint main(void) { " + case["cn_body"] + " return 0; }\n"), target
    if target == "verify_main" and group == "array_load":
        canonical = "IntArray::full(a,3,cons(0,cons(1,cons(2,nil))))"
        if canonical not in qcontract or "__return == 0" not in qcontract:
            raise ValueError(qcontract)
        strong = (ROOT / files["cn_original:array_load2"]["cn"]["path"]).read_text().split("int main(", 1)[0]
        body, n = re.subn(r"int a\[3\]\s*=\s*\{\s*0,\s*1,\s*2\s*\}\s*;", "", case["cn_body"])
        if n != 1:
            raise ValueError("expected one local array initializer to lift into the driver")
        resources = "each(integer j; 0 <= j && j < 3) { RW<int>(array_shift<int>(a,j)) }"
        specification = (
            "/*@ requires take before = "
            + resources
            + "; before[0] == 0; before[1] == 1; before[2] == 2; "
            + "ensures take after = "
            + resources
            + "; before == after; return == 0; @*/"
        )
        return (
            strong
            + "\nint comparison_region(int *a) "
            + specification
            + " { "
            + body
            + "\nreturn 0; }\nint main(void) { int a[3]={0,1,2}; return comparison_region(a); }\n"
        ), "comparison_region"
    if target == "main":
        strong = None
        if (
            group == "array_load"
            and pair.get("contract_comparison", {}).get("same_contract_comparison") is False
        ):
            strong = (ROOT / files["cn_original:array_load2"]["cn"]["path"]).read_text()
        return main_subject(original, case, qcontract, strong), "comparison_client"
    raise ValueError(f"no compiled companion for {group}/{target}")


def short_metric(data):
    return {
        k: data[k]
        for k in (
            "exit_code",
            "wall_seconds",
            "max_process_rss_kib",
            "tokens",
            "stdout_sha256",
            "stderr_sha256",
        )
    }


def diagnostic(work, stage):
    logs = "\n".join((work / (stage + "." + ext)).read_text(errors="replace") for ext in ("stdout", "stderr"))
    lines = [line.strip() for line in logs.splitlines() if line.strip()]
    for i, line in enumerate(lines):
        if any(
            w in line.lower()
            for w in (
                "failed at",
                "error:",
                "resource left",
                "cannot",
                "undefined reference",
                "unallocated",
                "ownership error",
            )
        ):
            return "\n".join(lines[i : i + 12])[:1800]
    return "\n".join(lines[-6:])[:600]


def checked_markers(unit, source, function):
    code = unit.read_text()
    definition = re.search(
        r"(?m)^.*?\b" + re.escape(function) + r"\([^;\n]*\)\s*\n?(?:/\*@[\s\S]*?\*/\s*)?\{", code
    )
    if not definition:
        raise ValueError(f"missing instrumented {function} definition")
    function_code = re.split(r"(?m)^int main\s*\(", code[definition.end() :], maxsplit=1)[0]
    # The target definition in Fulminate's generated translation unit must include ownership and postcondition checking.
    if function == "add":
        markers = [
            "Dll_at(n_cn, PRE",
            "Dll_at(return_cn, POST",
            "cn_integer_equality(Node(After_cn)->data, element_cn)",
        ]
    elif function == "remove":
        markers = [
            "Dll_at(n_cn, PRE",
            "Dll_at(ret_cn->node, POST",
            "ptr_eq(ret_cn->node, del_cn->next)",
            "ptr_eq(ret_cn->node, del_cn->prev)",
            "cn_integer_equality(ret_cn->data, del_cn->data)",
        ]
    else:
        markers = [
            "/* EXECUTABLE CN PRECONDITION */",
            "/* EXECUTABLE CN POSTCONDITION */",
            "cn_postcondition_leak_check();",
        ]
        if "ensures return == 0;" in source or function == "comparison_region":
            markers.append("cn_integer_equality(return_cn, convert_to_cn_integer(0))")
    if function == "add" and "element == 0" in source:
        markers.extend(["cn_integer_equality(element_cn, convert_to_cn_integer(0))", "is_null(return_cn)"])
    if function == "comparison_region":
        markers.extend(
            [
                "cn_map_equality(before_cn, after_cn, cn_integer_equality)",
                *(f"cn_map_get_cn_integer(before_cn, convert_to_cn_integer({i}))" for i in range(3)),
            ]
        )
    if any(m not in function_code for m in markers):
        raise ValueError(
            f"missing requested generated checks for {function}: {[m for m in markers if m not in function_code]}"
        )
    return markers


def run_one(group, pair, case, files, plan, scratch):
    path = scratch / group / case["id"]
    path.mkdir(parents=True, exist_ok=False)
    target = path / "subject.c"
    generated = path / "generated"
    generated.mkdir()
    source, function = make_subject(group, pair, case, files, plan)
    target.write_text(source)
    if group == "dll_add" or group == "dll_remove":
        cc = COMPILER if group == "dll_remove" else SHARED / "gcc-with-runtime.sh"
        includes = [SHARED / "Dbl_Linked_List", UPSTREAM]
    else:
        cc = ROOT / "tools/benchmark/gcc-no-builtins.sh"
        includes = [ROOT / "arxiv/fulminate-cn/src/examples" / "runtime-extras"]
    cmd = [
        str(CN),
        "instrument",
        "--run",
        "--cc=" + str(cc),
        "--output-dir=" + str(generated),
        *("-I" + str(i) for i in includes),
        str(target),
    ]
    stage = measured(cmd, path, "pipeline", "pipeline")
    receipt = {
        "source_sha256": sha(target),
        "compiler": relative(cc),
        "compiler_sha256": sha(cc),
        "include_dirs": [relative(p) for p in includes],
        "pipeline": short_metric(stage),
        "target": function,
        "tokens": 0,
        "model_calls": 0,
        "pipeline_diagnostic": diagnostic(path, "pipeline") if stage["exit_code"] else None,
    }
    try:
        exe = executable(generated)
    except RuntimeError:
        receipt["status"] = "NOT_BUILT"
        return receipt
    [unit] = generated.glob("*.exec.c")
    markers = checked_markers(unit, source, function)
    receipt.update(instrumented_sha256=sha(unit), binary_sha256=sha(exe), generated_checks=markers)
    checked = measured([str(exe)], path, "test", "test")
    receipt["test"] = short_metric(checked)
    if checked["exit_code"]:
        receipt["test_diagnostic"] = diagnostic(path, "test")
    if "Internal error: no error_msg_info available." in receipt.get("test_diagnostic", ""):
        probe = measured(
            [
                "/usr/bin/gdb",
                "-q",
                "-batch",
                "-ex",
                "break exit",
                "-ex",
                "run",
                "-ex",
                "bt",
                "--args",
                str(exe),
            ],
            path,
            "diagnostic",
            case["id"] + "/gdb",
        )
        trace = (path / "diagnostic.stdout").read_text(errors="replace")
        keys = ("c_ownership_check", "cn_free_sized", "cn_postcondition_leak_check", "cn_assert")
        receipt["fault_probe"] = {
            "cost": short_metric(probe),
            "frames": [k for k in keys if " in " + k + " (" in trace],
            "access": next((a for a in ("Load", "Store", "Free") if '"' + a + '"' in trace), None),
        }
    receipt["status"] = "PASS" if checked["exit_code"] == 0 else "FAIL"
    return receipt


def bound_source(record):
    path = ROOT / record["path"]
    if sha(path) != record["sha256"]:
        raise ValueError(f"changed source {path}")
    return path


def receipt_for_source(group, pair, case, files, plan, work, reuse, known):
    source, target = make_subject(group, pair, case, files, plan)
    digest = text_hash(source)
    ident = group + "/" + digest
    if ident in known:
        return ident
    if digest in reuse:
        receipt = reuse[digest]
    else:
        receipt = run_one(group, pair, case, files, plan, work)
        output = work / group / case["id"] / "receipt.json"
        output.write_text(json.dumps(receipt))
    if receipt["source_sha256"] != digest or receipt["target"] != target:
        raise ValueError("wrong generated source or target")
    known[ident] = receipt
    return ident


def phase(metric):
    return {
        "exit_code": metric["exit_code"],
        "wall_seconds": metric["wall_seconds"],
        "max_process_rss_kib": metric["resources"]["max_process_rss_kib"],
        "tokens": metric["tokens"],
        "model_calls": metric["model_calls"],
    }


def array_source_replay(pair, case, files, plan, old_rows, known):
    other = next(r for r in plan["pairings"] if r["cn_variant"] == "cn_original:array_load2")
    [match] = [c for c in other["cases"] if c["value"] == case["value"]]
    for field in ("cn_body", "binds", "expected"):
        if case[field] != match[field]:
            raise ValueError(f"array replay differs in {field}")

    def definition(variant):
        q = bound_source(files[variant]["qcp"]).read_text()
        definition = re.search(r"int\s+read\s*\([^)]*\)\s*/\*@[^\0]*?\*/\s*\{[^}]*\}", q)[0]
        return re.sub(r"\s+", "", definition)

    if definition(pair["qcp_variant"]) != definition(other["qcp_variant"]):
        raise ValueError("different QCP read definition")
    r = old_rows[(other["cn_variant"], match["id"])]
    record = files[other["cn_variant"]]["cn"]
    if (
        r["cn_source_sha256"] != record["sha256"]
        or r["qcp_source_sha256"] != files[other["qcp_variant"]]["qcp"]["sha256"]
    ):
        raise ValueError("archived array evidence is not bound to both declared source files")
    ident = "array_load/archive/" + r["harness_sha256"]
    known.setdefault(
        ident,
        {
            "kind": "archived_array_load2",
            "source": record,
            "target": "array_load_read",
            "source_sha256": r["harness_sha256"],
            "binary_sha256": r["instrumented_binary_sha256"],
            "archive_key": [other["cn_variant"], other["qcp_variant"], match["id"]],
            "pipeline": phase(r["fulminate_pipeline"]),
            "test": phase(r["fulminate_test"]),
            "status": "PASS" if r["fulminate_test"]["exit_code"] == 0 else "FAIL",
        },
    )
    return ident


def cause(observed, native):
    message = " ".join(observed.get(k, "") for k in ("stdout_diagnostic", "stderr_diagnostic"))
    reason = native.get("fault_code") or native["reason"]
    if observed["exit_code"] == 0:
        return "executed_without_rejection"
    same = {"missing_read_permission": "Load failed.", "missing_write_permission": "Store failed."}
    if reason in same and same[reason] in message:
        return "same_memory_fault"
    if reason == "invalid_safety_vc" and "ensures" in message and observed["exit_code"] == 2:
        return "postcondition_instead_of_c_safety"
    return "unattributed_rejection"


def collect(work, archived_answers):
    from collections import Counter

    coverage = load(RESULTS / "fulminate-coverage.json")["groups"]
    totals = Counter()
    all_rows = []
    by_group = {}
    receipts = {}
    for group, archive in coverage.items():
        plan_path = PROGRAMS / group / "evaluation-plan.json"
        plan = load(plan_path)
        files = sources(group)
        base = RESULTS / group
        original = load(base / "fulminate/results.json")
        baseline = base / "tespec/current-executions.json"
        autos = {(r["variant"], r["case"], r["strategy"]): r for r in load(baseline)["executions"]}
        overlay = baseline.with_name("auto-remaining.json")
        remaining = (
            {(r["variant"], r["case"], r["strategy"]): r for r in load(overlay)["executions"]}
            if overlay.is_file()
            else {}
        )
        limited = {
            (r["variant"], ident)
            for r in archive["scope_exceptions"]
            if r["kind"] == "target_contract_na"
            for ident in r["cases"]
        }
        finite = {
            (r["variant"], r.get("case", r.get("case_id"))): r
            for r in original.get("cases", original.get("runs", []))
        }
        evidence_path = (
            ROOT / original["evidence"]
            if isinstance(original.get("evidence"), str)
            else base / "fulminate/results.json"
        )
        evidence = load(evidence_path)
        raw = {
            (r["variant"], r.get("case", r.get("case_id"))): r
            for r in evidence.get("runs", evidence.get("cases", []))
        }
        used = {}
        for pair in plan["pairings"]:
            variant = pair["cn_variant"]
            qcp = pair["qcp_variant"]
            for case in pair["cases"]:
                key = variant, case["id"]
                strategy = {}
                differences = []
                for mode in ("inline", "modular"):
                    coord = qcp, case["id"], mode
                    native = autos[coord]
                    fresh = remaining.get(coord, native)
                    strategy[mode] = {
                        "expected": native["expected"],
                        "auto": fresh["effective_status"],
                        "matches_expected": fresh["expected_match"],
                        "native_report_sha256": native["native_report_sha256"],
                    }
                    differences.append(native["expected"] != finite[key]["expected"])
                if key in limited:
                    label = "body_only"
                elif pair.get("contract_comparison", {}).get("same_contract_comparison") is False:
                    label = "different_contract"
                elif all(differences):
                    label = "different_expected"
                elif group in ("dll_add", "dll_remove"):
                    label = "previously_included_dll_contract"
                else:
                    continue
                totals[label] += 1
                for role, var in (("cn", variant), ("qcp", qcp)):
                    info = files[var][role]
                    bound_source(info)
                    used.setdefault(var, {})[role] = info
                row = {
                    "group": group,
                    "cn_variant": variant,
                    "qcp_variant": qcp,
                    "case": case["id"],
                    "function": pair.get("function", plan["function"]),
                    "frozen_class": label,
                    "strategies": strategy,
                    "original_fulminate_expected": finite[key]["expected"],
                }
                all_rows.append(row)
                if label == "different_expected":
                    rr = raw[key]
                    test = rr.get("fulminate_test", rr.get("runtime_test"))
                    if not test:
                        raise ValueError("missing saved diagnostic")
                    causes = {cause(test, autos[qcp, case["id"], mode]) for mode in ("inline", "modular")}
                    if len(causes) != 1:
                        raise ValueError("per-strategy fault differs")
                    row.update(
                        profile="original_fault_labels",
                        diagnostic_class=causes.pop(),
                        fulminate_status="PASS" if test["exit_code"] == 0 else "FAIL",
                        stdout_sha256=test.get("stdout_sha256", test.get("stdout_omitted", {}).get("sha256")),
                        stderr_sha256=test.get("stderr_sha256", test.get("stderr_omitted", {}).get("sha256")),
                        tespec_fault=autos[qcp, case["id"], "inline"].get("fault_code")
                        or autos[qcp, case["id"], "inline"]["reason"],
                    )
                    continue
                if label == "different_contract":
                    if group != "array_load" or pair["function"] != "read":
                        raise ValueError("unclassified different contract")
                    ident = array_source_replay(pair, case, files, plan, raw, receipts)
                    row["profile"] = "array_read_strong"
                else:
                    subject_pair = pair
                    if group in ("dll_add", "dll_remove"):
                        subject_pair = next(p for p in plan["pairings"] if "orig.broken" in p["cn_variant"])
                        [other] = [c for c in subject_pair["cases"] if c["id"] == case["id"]]
                        if any(other[k] != case[k] for k in ("value", "cn_body", "binds")):
                            raise ValueError("DLL fixtures differ between source aliases")
                        row["profile"] = group + "_strengthened"
                    elif pair["function"] == "verify_main":
                        row["profile"] = "lifted_array_client"
                    elif pair["function"] == "bad_free":
                        row["profile"] = "empty_heap_free"
                    elif group == "array_load":
                        row["profile"] = "array_client_entry_exit"
                    elif group in ("succ_using_incr", "const_example_lessgood"):
                        row["profile"] = "empty_main_entry_exit"
                    else:
                        row["profile"] = "runtime_client_entry_exit"
                    ident = receipt_for_source(
                        group, subject_pair, case, files, plan, work, archived_answers, receipts
                    )
                row["fulminate_receipt"] = ident
                row["fulminate_status"] = receipts[ident]["status"]
        if used:
            by_group[group] = {
                "plan": {"path": relative(plan_path), "sha256": sha(plan_path)},
                "fulminate_evidence": {"path": relative(evidence_path), "sha256": sha(evidence_path)},
                "teSpec_native": {"path": relative(baseline), "sha256": sha(baseline)},
                "sources": used,
            }
            if overlay.is_file():
                by_group[group]["teSpec_overlay"] = {"path": relative(overlay), "sha256": sha(overlay)}
    return by_group, all_rows, receipts


PROFILES = {
    "array_read_strong": "Identical read definition, postcondition and input as the already measured CN array_load2 and its QCP read. The CN postcondition requires the full output map to equal the input map and the return to equal its indexed element. Six historical measurements serve 36 translations.",
    "dll_add_strengthened": "Typed allocated DLL nodes. The CN post now checks the new payload and each arm of QCP Dll. For n=NULL and element=0 the empty Dll(NULL,nil,0,nil) outcome is also legal. The original CN requires a nonempty singleton on this entry, and omits the payload equality. The companion checks the typed C allocation, including any padding that is outside QCP field-level assertions; comparison is confined to these typed fixtures. The C actions are token-identical across the two original CN variants.",
    "dll_remove_strengthened": "Typed allocated DLL nodes. Both contracts return ownership, the removed original payload, and the left/right value sequences. The companion also binds the returned node to the original next neighbor, else original previous neighbor, else NULL. The two original CN bodies are token-identical after proof-annotation removal. Comparison is confined to typed allocations; the CN object ownership can include padding.",
    "array_client_entry_exit": "Ordinary no-argument CN target with explicit return zero and an empty returned heap. Six original CN assertions are preserved. The called read contract follows the QCP helper (strong or weak). Interior assertions and local-array ownership encodings differ by QCP translation, so these are target-boundary comparisons only.",
    "lifted_array_client": "Client now receives an existing three-cell array with contents [0,1,2]. CN checks all three input cells, ownership and contents on exit, and return zero. The test driver owns the original local initializer. CN statement assertions and QCP local-resource assertions are not identical.",
    "empty_heap_free": "The original trusted helper is instrumented as an ordinary target with empty resource transfer at entry/exit. Original calls use the concrete nonzero pointer fixtures and free size unchanged. Debug tracing can confirm a runtime rejection when the normal CN reporter loses its source location.",
    "empty_main_entry_exit": "The original no-argument body is run as an ordinary target with an empty returned heap and return zero. The outer main only calls that target, so CN applies normal function-exit ownership checking.",
    "runtime_client_entry_exit": "Original concrete allocation client in an ordinary target; an empty returned heap is checked, with return-zero equality only when present in the QCP contract. Concrete allocator calls and original CN assertions are retained. Helper contracts, statement checks and transfer at external calls can differ; these targets must not be used as equal all-boundaries obligations.",
    "original_fault_labels": "No rerun or relabeling. Original Fulminate process diagnostics are compared with each strategy's original teSpec safety classification. Only matching access types with an explicit runtime diagnostic count as the same fault.",
}


def earlier_costs(directories):
    rows = []
    seen = set()
    for root in directories:
        for metric_path in sorted(root.rglob("*.time.json")):
            if metric_path.resolve() in seen:
                raise ValueError("duplicate prior measurement")
            seen.add(metric_path.resolve())
            directory = metric_path.parent
            original = directory / "subject.c"
            if not original.is_file():
                original = directory / "input.cn.c"
            receipt = load(directory / "receipt.json") if (directory / "receipt.json").is_file() else {}
            stage = metric_path.name.removesuffix(".time.json")
            method = receipt.get(stage, {})
            if stage == "diagnostic":
                method = receipt.get("fault_probe", {}).get("cost", {})
            usage = load(metric_path)
            rows.append(
                {
                    "group": directory.parent.name,
                    "case": directory.name,
                    "source_sha256": sha(original),
                    "stage": stage,
                    "stdout_sha256": sha(directory / (stage + ".stdout")),
                    "stderr_sha256": sha(directory / (stage + ".stderr")),
                    "wall_seconds": method.get("wall_seconds"),
                    "user_seconds": usage["user_seconds"],
                    "system_seconds": usage["system_seconds"],
                    "max_process_rss_kib": usage["max_process_rss_kib"],
                    "tokens": 0,
                }
            )
    return {
        "scope": "Earlier development smoke runs and the superseded DLL-add contract before modeling Dll(NULL,nil,0,nil). Independent of comparison costs. Some early smoke clocks retained CPU time and RSS only.",
        "measurements": rows,
    }


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("--work", type=Path, required=True, help="empty directory for new instrumented executions")
    p.add_argument(
        "--reuse",
        type=Path,
        action="append",
        default=[],
        help="resume a measurement directory produced by this script",
    )
    p.add_argument(
        "--earlier-attempts",
        type=Path,
        action="append",
        default=[],
        help="optional earlier experimental phases to retain separately from current measurements",
    )
    p.add_argument("--output", type=Path, required=True)
    args = p.parse_args()
    work = args.work.resolve()
    work.mkdir(parents=True, exist_ok=True)
    if any(work.iterdir()):
        p.error("--work must be empty; pass existing completed results with --reuse")
    installed_identity()
    reuse = {}
    for folder in args.reuse:
        for path in folder.glob("*/*/receipt.json"):
            value = load(path)
            workdir = path.parent
            source = workdir / "subject.c"
            if (
                sha(source) != value["source_sha256"]
                or sha(ROOT / value["compiler"]) != value["compiler_sha256"]
            ):
                raise ValueError("changed source or compiler in resumed measurement")
            for stage in ("pipeline", "test", "fault_probe"):
                if stage not in value:
                    continue
                name = "diagnostic" if stage == "fault_probe" else stage
                metric = value[stage]["cost"] if stage == "fault_probe" else value[stage]
                for stream in ("stdout", "stderr"):
                    if sha(workdir / (name + "." + stream)) != metric[stream + "_sha256"]:
                        raise ValueError("changed log file in resumed measurement")
            if "binary_sha256" in value:
                folder_generated = workdir / "generated"
                (unit,) = folder_generated.glob("*.exec.c")
                if (
                    sha(executable(folder_generated)) != value["binary_sha256"]
                    or sha(unit) != value["instrumented_sha256"]
                ):
                    raise ValueError("changed compiled program in resumed measurement")
                value["generated_checks"] = checked_markers(unit, source.read_text(), value["target"])
            reuse[value["source_sha256"]] = value
    groups, rows, receipts = collect(work, reuse)
    from collections import Counter

    keys = {(r["group"], r["cn_variant"], r["qcp_variant"], r["case"]) for r in rows}
    if len(keys) != len(rows):
        raise ValueError("duplicate companion row")
    counts = dict(Counter(r["frozen_class"] for r in rows))
    if counts != {
        "body_only": 51,
        "different_contract": 36,
        "different_expected": 32,
        "previously_included_dll_contract": 21,
    }:
        raise ValueError(f"unexpected excluded population {counts}")
    resources = {}
    for profile in ("archived_array_load2", "measured_companion"):
        chosen = [r for r in receipts.values() if r.get("kind", "measured_companion") == profile]
        resources[profile] = {
            "unique_executions": len(chosen),
            "statuses": dict(Counter(r["status"] for r in chosen)),
        }
        for stage in ("pipeline", "test", "fault_probe"):
            costs = [r[stage] if stage != "fault_probe" else r[stage]["cost"] for r in chosen if stage in r]
            resources[profile][stage] = {
                "invocations": len(costs),
                "wall_seconds": sum(c["wall_seconds"] for c in costs),
                "max_process_rss_kib": max((c["max_process_rss_kib"] for c in costs), default=None),
                "tokens": 0,
            }
    output = {
        "schema": "fulminate-supplemental-contract-comparison/v1",
        "scope": "Independent companion profiles; keep the frozen matrix and original expected labels. Each receipt is charged once regardless of aliases. CN PASS/FAIL/NOT_BUILT reflect the recorded standalone run or build; a bare failure without an attributable safety event is not evidence of the matching violation.",
        "counts": counts,
        "diagnostic_classes": dict(Counter(r["diagnostic_class"] for r in rows if "diagnostic_class" in r)),
        "profiles": PROFILES,
        "costs": resources,
        "implementation": {
            "path": relative(Path(__file__).resolve()),
            "sha256": sha(Path(__file__).resolve()),
        },
        "cn_toolchain": {
            "lock": "tools/benchmark/cn-toolchain.json",
            "lock_sha256": sha(ROOT / "tools/benchmark/cn-toolchain.json"),
            "cn_sha256": sha(CN),
        },
        "dependencies": {
            relative(p): sha(p)
            for p in sorted(
                {
                    *SHARED.rglob("*.h"),
                    SHARED / "gcc-with-runtime.sh",
                    SHARED / "allocator-runtime.c",
                    UPSTREAM / "node_and_int.h",
                    COMPILER,
                    COMPILER.parent / "pair-runtime.c",
                    *PROGRAMS.glob("dll_*/*/qcp_existing_*/*/coq/DLLSupplement.v"),
                }
            )
        },
        "groups": groups,
        "measurements": receipts,
        "rows": rows,
    }
    if args.earlier_attempts:
        output["earlier_attempts"] = earlier_costs(args.earlier_attempts)
    args.output.write_text(json.dumps(output, ensure_ascii=False, separators=(",", ":")) + "\n")
    print(counts, output["diagnostic_classes"], resources)


if __name__ == "__main__":
    main()
