#!/usr/bin/env python3
"""Rebuild the legacy Fulminate finite-input fixtures with the locked CN installation."""

import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from hashlib import sha256
import json
from pathlib import Path
import re

from cn_toolchain import CN, ROOT, installed_identity
from replay_dll_remove_fulminate import executable, measured

GROUPS = ("mergesort", "queue_all", "slf_sized_stack", "list_all", "runway__funcs2")
HEADER_ROOT = ROOT / "arxiv/fulminate-cn/src/examples/runway"


def read(path):
    return json.loads(path.read_bytes())


def save(path, value):
    with path.open("w") as handle:
        json.dump(value, handle, ensure_ascii=False, separators=(",", ":"))
        handle.write("\n")


def digest(path):
    return sha256(path.read_bytes()).hexdigest()


def join_clauses(match):
    # Older CN allowed multiple magic comments with repeated clause keywords.
    pieces = re.findall(r"/\*@\s*(requires|ensures)\b([\s\S]*?)@?\*/", match[0])
    statements = []
    previous = None
    for kind, expr in pieces:
        statements.append((kind + " " if kind != previous else "") + expr.strip())
        previous = kind
    return "/*@ " + "\n".join(statements) + " @*/\n"


def cn_numbers(match):
    # The locked CN installation represents loaded C integer fields by integer.
    # Benchmark inputs are finite and small; the profile is not an unbounded
    # equivalence claim about mathematical vs machine-integer arithmetic.
    text = match[0].replace("1u32 + length(zs)", "mod(1 + length(zs), 4294967296)")
    text = text.replace("n + length(L1)", "mod(n + length(L1), 4294967296)")
    for operand in ("num_elements", "return.Plane_Counter"):
        text = text.replace(
            operand + " - 1i32",
            "(" + operand + " == -2147483648 ? 2147483647 : " + operand + " - 1)",
        )
    text = re.sub(r"(\d+)(?:i32|u32)\b", r"\1", text)
    # Casts of a C signed int to unsigned int wrap modulo 2^32.
    text = text.replace(
        "(u32) num_elements",
        "(num_elements < 0 ? num_elements + 4294967296 : num_elements)",
    )
    text = text.replace("(i32) num_elements", "num_elements")
    text = re.sub(r"\(i64\) (s\.\w+) < 2147483647i64", r"\1 < 2147483647", text)
    return re.sub(r"\b(?:i32|u32)\b", "integer", text)


def adapt(group, source):
    if group == "runway__funcs2":
        # Expand the local headers so return/epilogue instrumentation has the
        # same source location domain as the original function body.
        for name in ("state", "valid_state", "funcs1"):
            header = (HEADER_ROOT / (name + ".h")).read_text()
            if name == "state":
                for label in ("ACTIVE", "INACTIVE"):
                    literal = re.search(
                        r"^#define " + label + r" (\d+)$", header, re.M
                    )[1]
                    header = header.replace(
                        "function (i32) " + label + " () @*/",
                        "function (i32) " + label + " () { " + literal + "i32 } @*/",
                    )
                    header = header.replace("/*@ cn_function " + label + "; @*/", "")
            if name == "valid_state":
                header = header.replace(
                    "function (bool) valid_state", "function (boolean) valid_state"
                )
            source = source.replace('#include "' + name + '.h"', header)
    if group == "queue_all":
        pattern = (
            r"/\*@\s*predicate \(datatype seq\) (IntQueue(?:Ptr|FB|Aux))\b[\s\S]*?@\*/"
        )
        blocks = list(re.finditer(pattern, source))
        names = [block[1] for block in blocks]
        if names != ["IntQueuePtr", "IntQueueFB", "IntQueueAux"]:
            raise ValueError("unexpected queue declaration set")
        start, end = blocks[0].start(), blocks[-1].end()
        if re.sub(pattern, "", source[start:end]).strip():
            raise ValueError("queue predicate declarations are not adjacent")
        body = "\n\n".join(block[0] for block in reversed(blocks))
        source = (
            source[:start]
            + body.replace(
                "predicate (datatype seq) IntQueueAux",
                "predicate [rec] (datatype seq) IntQueueAux",
            )
            + source[end:]
        )
    source = source.replace(
        "predicate (datatype seq) IntList(", "predicate [rec] (datatype seq) IntList("
    )
    source = re.sub(
        r"(?:/\*@\s*(?:requires|ensures)\b(?:(?!\*/)[\s\S])*?\*/\s*){2,}",
        join_clauses,
        source,
    )
    return re.sub(r"/\*@[\s\S]*?\*/", cn_numbers, source)


def target_contract(source, name):
    # A function name must begin on a definition line following its C type.
    start = re.search(
        r"(?m)^(?:static\s+)?(?:struct\s+\w+|unsigned\s+int|int|void|unsigned|bool)\s*\**\s*"
        + re.escape(name)
        + r"\s*\([^;{}]*\)\s*(?:(?:/\*[\s\S]*?\*/|//[^\n]*\n)\s*)*\{",
        source,
    )
    if not start:
        return None
    rest = source[start.end() :]
    # The front end prints the closing brace of an instrumented function at
    # column zero, but nested source blocks may also exhibit that layout. Use
    # balanced braces, excluding C comments, strings and character literals.
    depth = 1
    for token in re.finditer(
        r"""/\*[\s\S]*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|[{}]""", rest
    ):
        if token[0] == "{":
            depth += 1
        if token[0] == "}":
            depth -= 1
        if depth == 0:
            return rest[: token.start()]
    return None


def check_instrumentation(row, work, function):
    (compiled,) = (work / "generated").glob("*.exec.c")
    body = target_contract(compiled.read_text(), function)
    row["instrumentation"] = {
        "generated_sha256": digest(compiled),
        "binary_sha256": digest(executable(work / "generated")),
        "definition_found": body is not None,
        "pre_marker": bool(body and "/* EXECUTABLE CN PRECONDITION */" in body),
        "post_marker": bool(body and "/* EXECUTABLE CN POSTCONDITION */" in body),
    }
    row["contract_checked"] = bool(
        row["instrumentation"]["pre_marker"] and row["instrumentation"]["post_marker"]
    )


def run(task):
    folder, group, old, function, case, prior = task
    folder.mkdir(parents=True, exist_ok=True)
    dest = folder / "measurement.json"
    original = ROOT / old["harness"]
    if (
        digest(original) != old["harness_sha256"]
        or old["plan_case"]["cn_body"] != case["cn_body"]
    ):
        raise ValueError("frozen harness or driver differs from evaluation plan")
    subject = folder / "subject.c"
    rendered = adapt(group, original.read_text()).encode()
    rendered_sha = sha256(rendered).hexdigest()
    if dest.exists():
        receipt = read(dest)
        if (
            receipt["executed_source_sha256"] != rendered_sha
            or receipt["function"] != function
            or any(
                receipt[key] != old[key]
                for key in (
                    "variant",
                    "paired_qcp_variant",
                    "case",
                    "harness_sha256",
                    "cn_source_sha256",
                )
            )
        ):
            raise ValueError("cached result does not match the current frozen fixture")
        measured_dir = folder if (folder / "pipeline.time.json").is_file() else prior
        if not measured_dir or digest(measured_dir / "subject.c") != rendered_sha:
            raise ValueError("missing measured compatibility fixture")
        for stage, label in (("build", "pipeline"), ("test", "test")):
            if stage not in receipt:
                continue
            cost = receipt[stage]
            if (
                digest(measured_dir / (label + ".stderr")) != cost["stderr_sha256"]
                or digest(measured_dir / (label + ".stdout")) != cost["stdout_sha256"]
                or read(measured_dir / (label + ".time.json"))["max_process_rss_kib"]
                != cost["max_process_rss_kib"]
            ):
                raise ValueError("recorded process evidence differs")
        if "instrumentation" in receipt:
            original_instrumentation = receipt["instrumentation"].copy()
            check_instrumentation(receipt, measured_dir, function)
            if original_instrumentation != receipt["instrumentation"]:
                raise ValueError("generated contract instrumentation differs")
        return receipt
    subject.write_bytes(rendered)
    previous = (
        read(prior / "measurement.json")
        if prior and (prior / "measurement.json").is_file()
        else None
    )
    if previous and previous["executed_source_sha256"] == digest(subject):
        if (
            previous["case"] != case["id"]
            or previous["cn_source_sha256"] != old["cn_source_sha256"]
            or previous["harness_sha256"] != old["harness_sha256"]
        ):
            raise ValueError("prior measurement input mismatch")
        check_instrumentation(previous, prior, function)
        save(dest, previous)
        return previous
    gen = folder / "generated"
    gen.mkdir()
    key = group + "/" + original.parent.name
    compile_run = measured(
        [
            str(CN),
            "instrument",
            "--allow-split-magic-comments",
            "--run",
            "--output-dir=" + str(gen),
            str(subject),
        ],
        folder,
        "pipeline",
        key + "/pipeline",
    )
    expected = case.get("expected_by_tool", {}).get("fulminate_test", case["expected"])
    row = {
        k: old[k]
        for k in (
            "variant",
            "paired_qcp_variant",
            "case",
            "initial",
            "cn_source_sha256",
            "harness_sha256",
        )
    }
    row.update(
        function=function,
        expected=expected,
        actual="NOT_BUILT",
        raw_actual="NOT_BUILT",
        matches_expected=False,
        executed_source_sha256=digest(subject),
        build=compact(compile_run),
    )
    programs = list(gen.glob("*.exec.out"))
    row["contract_checked"] = False
    if programs:
        binary = executable(gen)
        check_instrumentation(row, folder, function)
        result = measured([str(binary)], folder, "test", key + "/test")
        if result["exit_code"] == 0:
            status = "PASS"
        elif result["exit_code"] in (124, 137):
            status = "TIMEOUT"
        else:
            status = "FAIL"
        row.update(
            actual=status,
            raw_actual=status,
            matches_expected=status == expected,
            test=compact(result),
        )
        if status != expected:
            row["diagnostic"] = diagnostic(
                folder / "test.stderr", folder / "test.stdout"
            )
    else:
        row["diagnostic"] = diagnostic(
            folder / "pipeline.stderr", folder / "pipeline.stdout"
        )
    if previous:
        row["previous_attempt"] = {
            k: previous[k]
            for k in ("actual", "executed_source_sha256", "build", "test")
        }
    save(dest, row)
    return row


def diagnostic(*logs):
    for log in logs:
        lines = [
            ln for ln in log.read_text(errors="replace").splitlines() if ln.strip()
        ]
        if lines:
            return "\n".join(lines[-9:])[-1200:]
    return "no diagnostic output"


def compact(metric):
    return {
        k: metric[k]
        for k in (
            "wall_seconds",
            "max_process_rss_kib",
            "exit_code",
            "stdout_sha256",
            "stderr_sha256",
            "tokens",
        )
    }


def totals(rows, key):
    measured_rows = [r[key] for r in rows if r.get(key)]
    return {
        "attempts": len(measured_rows),
        "wall_seconds": sum(r["wall_seconds"] for r in measured_rows),
        "max_process_rss_kib": max(
            (r["max_process_rss_kib"] for r in measured_rows), default=None
        ),
        "tokens": 0,
    }


def locked_original(task, scratch):
    _, group, old, _, _, _ = task
    subject = ROOT / old["harness"]
    folder = scratch / group / old["case"]
    folder.mkdir(parents=True, exist_ok=True)
    dest = folder / "measurement.json"
    if dest.exists():
        row = read(dest)
        if row["harness_sha256"] != digest(subject) or row["build"][
            "stderr_sha256"
        ] != digest(folder / "pipeline.stderr"):
            raise ValueError("unmodified fixture receipt does not match")
        return row
    out = folder / "generated"
    out.mkdir()
    command = [
        str(CN),
        "instrument",
        "--allow-split-magic-comments",
        "--run",
        "--output-dir=" + str(out),
    ]
    if group == "runway__funcs2":
        command.append("-I" + str(HEADER_ROOT))
    command.append(str(subject))
    cost = measured(
        command, folder, "pipeline", "original/" + group + "/" + old["case"]
    )
    errors = (folder / "pipeline.stderr").read_text(errors="replace").splitlines()
    row = {
        "harness_sha256": digest(subject),
        "status": "BUILT" if list(out.glob("*.exec.out")) else "NOT_BUILT",
        "diagnostic": next(
            (line.split("error:", 1)[1].strip() for line in errors if "error:" in line),
            None,
        ),
        "build": compact(cost),
    }
    save(dest, row)
    return row


def compatible_profile(group, source):
    helpers = re.findall(r"\b(\w+)\s*\([^()]*\)\s*/\*@\s*trusted", source)
    return {
        "scope": "Concrete finite tests under migrated legacy CN syntax and locked runtime. No new trusted functions or bounded predicate unfoldings.",
        "driver": "Frozen main creates the plan input, calls the target and exits. Checks are inserted into the target pre/post and enabled inline annotations. Driver has no independent result oracle.",
        "original_main": "replaced" if "main" in helpers else "driver appended",
        "existing_trusted_functions": [f for f in helpers if f != "main"],
        "existing_lemmas": re.findall(r"(?m)^\s*lemma\s+(\w+)", source),
        "integers": "C-derived 32-bit values represented as CN integers. Width-sensitive length and unsigned accumulator addition use modulo 2^32, signed decrement and unsigned casts retain their 32-bit boundary values. No universal equivalence claim.",
        "headers": {
            p.name: digest(p)
            for p in [
                HEADER_ROOT / name for name in ("state.h", "valid_state.h", "funcs1.h")
            ]
        }
        if group == "runway__funcs2"
        else {},
        "declarations": {
            "slf_sized_stack": "Declare recursive IntList explicitly.",
            "queue_all": "Order IntQueueAux, IntQueueFB, IntQueuePtr by dependency; mark IntQueueAux recursive. Original assert_not_equal lemma remains conditional.",
            "list_all": "Mark IntList recursive; combine consecutive requires/ensures blocks.",
            "mergesort": "Mark IntList recursive; combine consecutive requires/ensures blocks.",
            "runway__funcs2": "Include the original three headers textually, change bool to boolean in valid_state and bind ACTIVE/INACTIVE to their C macro constants in logic.",
        }[group],
    }


def c_tokens(text):
    # Lexically compare C after stripping original/compatibility annotations.
    return [
        m[0]
        for m in re.finditer(
            r"""/\*[\s\S]*?\*/|//[^\n]*|"(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*'|\w+|[^\s]""",
            text,
        )
        if not m[0].startswith(("/*", "//"))
    ]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--group", choices=GROUPS, action="append")
    parser.add_argument("--workers", default=4, type=int)
    parser.add_argument("--publish", action="store_true")
    parser.add_argument(
        "--prior-scratch",
        type=Path,
        help="Reuse matching process measurements and retain earlier attempt costs",
    )
    parser.add_argument(
        "--original-scratch",
        type=Path,
        help="Reproduce original unmodified fixture attempts with the same pinned toolchain",
    )
    args = parser.parse_args()
    if args.publish and args.original_scratch is None:
        parser.error("publishing requires same-toolchain original measurements")
    tool = installed_identity()
    for group in args.group or GROUPS:
        base = ROOT / "benchmark/results" / group
        plan_path = ROOT / "benchmark/programs" / group / "evaluation-plan.json"
        archive = base / "20261016-evaluation/results.json"
        old = {(r["paired_qcp_variant"], r["case"]): r for r in read(archive)["runs"]}
        manifest = read(ROOT / "benchmark/programs" / group / "manifest.json")
        cn_sources = {}
        for variant in manifest["variants"]:
            files = read(ROOT / variant["manifest"])["files"]
            if "cn" in files:
                src = files["cn"]
                if digest(ROOT / src["path"]) != src["sha256"]:
                    raise ValueError("CN source differs from its variant manifest")
                cn_sources[variant["id"]] = src["sha256"]
        (source,) = [
            read(ROOT / v["manifest"])["files"]["cn"]
            for v in manifest["variants"]
            if v["id"] in cn_sources
        ]
        original_source = (ROOT / source["path"]).read_text()
        original_main = re.search(r"\bint\s+main\s*\(", original_source)
        prefix = (
            original_source[: original_main.start()]
            if original_main
            else original_source
        ).strip()
        tasks = []
        for pairing in read(plan_path)["pairings"]:
            for case in pairing["cases"]:
                row = old[pairing["qcp_variant"], case["id"]]
                if (
                    row["variant"] != pairing["cn_variant"]
                    or row["cn_source_sha256"] != cn_sources[pairing["cn_variant"]]
                ):
                    raise ValueError("variant mismatch")
                harness = (ROOT / row["harness"]).read_text()
                before, sep, driver = harness.rpartition("int main(void)")
                if before.strip() != prefix or not sep or case["cn_body"] not in driver:
                    raise ValueError(
                        "fixture body or driver differs from the planned program"
                    )
                expanded = harness
                if group == "runway__funcs2":
                    for filename in ("state.h", "valid_state.h", "funcs1.h"):
                        expanded = expanded.replace(
                            '#include "' + filename + '"',
                            (HEADER_ROOT / filename).read_text(),
                        )
                if c_tokens(expanded) != c_tokens(adapt(group, harness)):
                    raise ValueError("compatibility edits changed C tokens")
                tasks.append(
                    (
                        args.scratch.resolve() / group / case["id"],
                        group,
                        row,
                        pairing["function"],
                        case,
                        args.prior_scratch.resolve() / group / case["id"]
                        if args.prior_scratch
                        else None,
                    )
                )
        if len(tasks) != len(old) or len({t[0] for t in tasks}) != len(old):
            raise ValueError("missing or duplicate frozen cases")
        with ThreadPoolExecutor(args.workers) as pool:
            rows = list(pool.map(run, tasks))
            if args.original_scratch:
                originals = list(
                    pool.map(
                        lambda t: locked_original(t, args.original_scratch.resolve()),
                        tasks,
                    )
                )
                for row, original in zip(rows, originals):
                    row["locked_original"] = original
        counts = dict(Counter(r["actual"] for r in rows))
        print(group, counts, flush=True)
        if args.publish:
            target = base / "fulminate"
            summary = {
                "target_contracts_checked": sum(r["contract_checked"] for r in rows),
                "case_pairs": len(rows),
                "correct": sum(r["matches_expected"] for r in rows),
                "native_status_counts": counts,
            }
            save(
                target / "results.json",
                {
                    "tool": "fulminate",
                    "program_group": group,
                    "profile": "cn-5.2-finite-integer-compat/v1",
                    "cn_sha256": tool["cn_sha256"],
                    "toolchain_lock": "tools/benchmark/cn-toolchain.json",
                    "source_profile": "original C implementation and frozen drivers; legacy CN annotations adapted for locked integer-domain runtime",
                    "compatibility": compatible_profile(group, original_source),
                    "locked_original_outcomes": dict(
                        Counter(r["locked_original"]["status"] for r in rows)
                    ),
                    "previous_attempts": str(archive.relative_to(ROOT)),
                    "plan_sha256": digest(plan_path),
                    "adapter_sha256": digest(Path(__file__)),
                    "summary": summary,
                    "cases": rows,
                },
            )
            save(
                target / "statistics.json",
                {
                    "instrument_compile_initial_execution_wall_seconds_total": totals(
                        rows, "build"
                    )["wall_seconds"],
                    "test_execution_wall_seconds_total": totals(rows, "test")[
                        "wall_seconds"
                    ],
                    "pipeline_peak_process_rss_kib": totals(rows, "build")[
                        "max_process_rss_kib"
                    ],
                    "test_peak_process_rss_kib": totals(rows, "test")[
                        "max_process_rss_kib"
                    ],
                    "tokens": 0,
                    "model_calls": 0,
                    "locked_original_build_cost": totals(
                        [r["locked_original"] for r in rows], "build"
                    ),
                    "pipeline_attempts": len(rows),
                    "test_attempts": totals(rows, "test")["attempts"],
                    "previous_attempts": str(archive.relative_to(ROOT)),
                    "earlier_compatibility_attempt_costs": {
                        key: totals(
                            [
                                r["previous_attempt"]
                                for r in rows
                                if r.get("previous_attempt")
                            ],
                            key,
                        )
                        for key in ("build", "test")
                    },
                },
            )


if __name__ == "__main__":
    main()
