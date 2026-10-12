#!/usr/bin/env python3
"""Typed-program E2E matrix through the public CLI, with native/Python oracles."""

from __future__ import annotations
import argparse
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor, as_completed
import hashlib
import json
import platform
from pathlib import Path
import re
import subprocess
import sys
import time

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from benchmark.executor_e2e.cases import programs, scenarios  # noqa: E402
from spectest.core import bundled_qcp_binary, bundled_qcip_root  # noqa: E402


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def write_json(path, obj):
    path.write_text(json.dumps(obj, indent=2, ensure_ascii=False) + "\n")


def native_run(source, inputs, directory, cc):
    directory.mkdir(parents=True, exist_ok=True)
    plain = re.sub(r'^\s*#include\s+"verification_list.h"\s*$', "", source, flags=re.M)
    main = ["\n#include <stdio.h>\nint main(void) {"]
    for case in inputs:
        values = ["result"] + case["native_observe"]
        fmt = "[" + ",".join(["%d"] * len(values)) + "]\\n"
        main.append(
            "{ "
            + case["native_setup"]
            + " int result=sample("
            + case["native_args"]
            + "); "
            + 'printf("'
            + fmt
            + '",'
            + ",".join(values)
            + "); }"
        )
    main.append("return 0; }")
    cpath = directory / "oracle.c"
    cpath.write_text(plain + "\n".join(main))
    binary = directory / "oracle"
    compiled = subprocess.run(
        [cc, "-std=c11", "-O0", "-Wall", "-Wextra", str(cpath), "-o", str(binary)],
        capture_output=True,
        text=True,
        timeout=30,
    )
    (directory / "compile.log").write_text(compiled.stdout + compiled.stderr)
    if compiled.returncode:
        raise RuntimeError("native compile failed: " + str(directory / "compile.log"))
    run = subprocess.run([str(binary)], capture_output=True, text=True, timeout=5)
    (directory / "stdout.log").write_text(run.stdout)
    if run.returncode:
        raise RuntimeError("native execution failed: " + run.stderr)
    outputs = [json.loads(line) for line in run.stdout.splitlines()]
    if len(outputs) != len(inputs):
        raise RuntimeError("native result count mismatch")
    return outputs


def main():
    ap = argparse.ArgumentParser(description=__doc__)
    ap.add_argument("--binary", type=Path, default=bundled_qcp_binary())
    ap.add_argument("--runtime", type=Path, default=bundled_qcip_root())
    ap.add_argument("--output", type=Path, required=True)
    ap.add_argument("--category", action="append", default=[])
    ap.add_argument("--program", action="append", default=[])
    ap.add_argument("--jobs", type=int, default=4)
    ap.add_argument("--cc", default="cc")
    ap.add_argument("--negative-standard", choices=("weak", "strong"), default="weak")
    args = ap.parse_args()
    if args.jobs < 1:
        ap.error("--jobs must be positive")
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        ap.error("--output must be empty; each run retains its own evidence")
    out.mkdir(parents=True, exist_ok=True)
    binary_sha256 = digest(args.binary)
    started = time.monotonic()
    tasks = []
    inventory = []
    native_failures = []
    for program in programs():
        if args.category and program.category not in args.category:
            continue
        if args.program and program.name not in args.program:
            continue
        base = out / "artifacts" / program.category / program.name
        try:
            native = native_run(
                program.source, program.inputs, base / "native-reference", args.cc
            )
            expected = [case["oracle"] for case in program.inputs]
            if native != expected:
                raise RuntimeError(
                    f"Python/native mismatch: expected {expected}, got {native}"
                )
            variants = [("reference", program.source, native)]
            if "wrong_post" in program.variants:
                variants.append(("wrong_post", program.source, native))
            if program.mutation and "wrong_body" in program.variants:
                old, new = program.mutation
                mutant = program.source.replace(old, new, 1)
                observed = native_run(
                    mutant, program.inputs, base / "native-mutant", args.cc
                )
                if observed == expected:
                    raise RuntimeError("mutation not distinguished by any input")
                variants.append(("wrong_body", mutant, observed))
        except Exception as error:
            native_failures.append({"program": program.name, "error": str(error)})
            continue
        for variant, source, observed in variants:
            directory = base / variant
            directory.mkdir(parents=True, exist_ok=True)
            path = directory / "program.c"
            path.write_text(source)
            binds = []
            expectations = {}
            for case, actual in zip(program.inputs, observed, strict=True):
                bind = {k: case[k] for k in ["id", "args", "values"]}
                bind = json.loads(json.dumps(bind))
                mismatch = actual != case["oracle"]
                if variant == "wrong_post":
                    bind["values"]["expected"] += 1
                    mismatch = True
                binds.append(bind)
                expectations[case["id"]] = {
                    "overall": "UNKNOWN" if mismatch else "PASS",
                    "precondition": "SAT",
                    "safety": "PASS",
                    "execution": "PASS",
                    "postcondition": "UNKNOWN" if mismatch else "PASS",
                    "oracle": case["oracle"],
                    "native_observed": actual,
                    "negative": mismatch,
                }
            binds_path = directory / "binds.json"
            write_json(binds_path, binds)
            write_json(directory / "expected.json", expectations)
            inventory.append(
                {
                    "program": program.name,
                    "category": program.category,
                    "variant": variant,
                    "source": str(path),
                    "source_sha256": digest(path),
                    "binds_sha256": digest(binds_path),
                    "cases": len(binds),
                }
            )
            for mode in ["expand", "no-expand"]:
                tasks.append(
                    (
                        program.name,
                        program.category,
                        variant,
                        mode,
                        path,
                        binds_path,
                        expectations,
                        {},
                    )
                )
    for case in scenarios():
        if args.category and case["category"] not in args.category:
            continue
        if args.program and case["name"] not in args.program:
            continue
        directory = out / "artifacts" / case["category"] / case["name"]
        directory.mkdir(parents=True, exist_ok=True)
        source = directory / "program.c"
        source.write_text(case["source"])
        binds = directory / "binds.json"
        write_json(binds, case["binds"])
        write_json(directory / "expected.json", case["expected"])
        inventory.append(
            {
                "program": case["name"],
                "category": case["category"],
                "variant": "scenario",
                "source": str(source),
                "source_sha256": digest(source),
                "binds_sha256": digest(binds),
                "cases": len(case["binds"]),
            }
        )
        for mode in ["expand", "no-expand"]:
            tasks.append(
                (
                    case["name"],
                    case["category"],
                    "scenario",
                    mode,
                    source,
                    binds,
                    case["expected"][mode],
                    case["options"],
                )
            )
    write_json(out / "inventory.json", inventory)
    if not tasks and not native_failures:
        ap.error("filters selected no programs or scenarios")

    def run(task):
        name, category, variant, mode, path, binds, expected, options = task
        dest = path.parent / mode
        command = [
            sys.executable,
            "-m",
            "spectest",
            "run",
            str(path),
            "--function",
            "sample",
            "--binds",
            str(binds),
            "--qcp-binary",
            str(args.binary.resolve()),
            "--qcip-root",
            str(args.runtime.resolve()),
            "--execution-mode",
            mode,
            "--loop-unroll-limit",
            str(options.get("loop_unroll_limit", 24)),
            "--call-depth-limit",
            str(options.get("call_depth_limit", 32)),
            "--timeout",
            "15",
            "--output-dir",
            str(dest),
        ]
        proc = subprocess.run(
            command, cwd=ROOT, capture_output=True, text=True, timeout=180
        )
        dest.mkdir(parents=True, exist_ok=True)
        (dest / "controller.stdout").write_text(proc.stdout)
        (dest / "controller.stderr").write_text(proc.stderr)
        if not (dest / "report.json").exists():
            return [
                {
                    "program": name,
                    "category": category,
                    "variant": variant,
                    "mode": mode,
                    "differences": {"controller": proc.stderr},
                    "status": "ERROR",
                    "report": str(dest / "report.json"),
                }
            ]
        report = json.loads((dest / "report.json").read_text())
        results = []
        actual_ids = [r["id"] for r in report["results"]]
        if Counter(actual_ids) != Counter(expected.keys()):
            raise RuntimeError(
                f"report case IDs differ: expected {list(expected)}, got {actual_ids}"
            )
        for result in report["results"]:
            want = expected[result["id"]]
            got = {
                **result["phases"],
                "overall": result["status"],
                "reason": result["reason"],
                "scope": result["scope"],
            }
            negative = want.get("negative") is True
            allowed = {"FAIL", "UNKNOWN"} if args.negative_standard == "weak" else {"FAIL"}
            canonical = result.get("test_result")
            if canonical not in {"PASS", "FAIL", "UNKNOWN"}:
                canonical = "UNKNOWN"
            overall_matches = canonical in allowed if negative else got["overall"] == want.get("overall")
            if want.get("overall") == "INVALID" and want.get("precondition") == "UNSAT":
                overall_matches = got["overall"] == "FAIL"
            differences = {
                key: {"expected": val, "actual": got.get(key)}
                for key, val in want.items()
                if key
                not in [
                    "oracle",
                    "native_observed",
                    "negative",
                    "negative_kind",
                    "expect_artifacts",
                ]
                and got.get(key) != val
                and not (key == "overall" and overall_matches)
            }
            if negative and not overall_matches:
                differences["overall"] = {"expected": sorted(allowed), "actual": canonical}
            files = result.get("vc", {}).get("files", {})
            for key in ["goal", "proof_auto", "proof_manual", "goal_check"]:
                if want.get("expect_artifacts", True) and (
                    not files.get(key) or not Path(files[key]).is_file()
                ):
                    differences["artifact_" + key] = "missing"
            for key, val in result.get("vc", {}).get("immutable_sha256", {}).items():
                if files.get(key) and digest(files[key]) != val:
                    differences["hash_" + key] = "mismatch"
            executor_path = Path(result.get("stdout", ""))
            if executor_path.is_file():
                for key in ["duration_seconds", "peak_rss_kb", "cpu_seconds"]:
                    if not isinstance(result.get(key), (int, float)) or result[key] < 0:
                        differences[key] = "missing resource measurement"
                try:
                    ej = json.loads(executor_path.read_text())
                    if (
                        ej.get("spec_test", {}).get("execution_semantics")
                        != "inline-preserve/v1"
                    ):
                        differences["execution_semantics"] = "wrong binary semantics"
                    if (
                        want["negative"]
                        and want.get("expect_artifacts", True)
                        and want.get("negative_kind", "return_checker_wit") is not None
                        and not any(
                            v.get("kind")
                            == want.get("negative_kind", "return_checker_wit")
                            for v in ej.get("manual_obligations") or []
                        )
                    ):
                        differences["negative_vc"] = "missing return obligation"
                except ValueError:
                    differences["executor_json"] = "invalid JSON"
            results.append(
                {
                    "program": name,
                    "category": category,
                    "variant": variant,
                    "mode": mode,
                    "case": result["id"],
                    "status": result["status"],
                    "test_result": canonical,
                    "phases": result["phases"],
                    "negative": want["negative"],
                    "differences": differences,
                    "report": str(dest / "report.json"),
                    "wall_seconds": result.get("duration_seconds"),
                    "cpu_seconds": result.get("cpu_seconds"),
                    "peak_rss_kib": result.get("peak_rss_kb"),
                }
            )
        return results

    results = []
    with ThreadPoolExecutor(max_workers=args.jobs) as pool:
        pending = {pool.submit(run, t): t for t in tasks}
        for future in as_completed(pending):
            task = pending[future]
            try:
                results.extend(future.result())
            except Exception as error:
                results.append(
                    {
                        "program": task[0],
                        "category": task[1],
                        "variant": task[2],
                        "mode": task[3],
                        "status": "ERROR",
                        "differences": {"runner": str(error)},
                    }
                )
            if len(results) % 48 == 0:
                print(f"{len(results)} cases completed", flush=True)
    results.sort(
        key=lambda r: (
            r["category"],
            r["program"],
            r["variant"],
            r["mode"],
            r.get("case", ""),
        )
    )
    categories = defaultdict(Counter)
    for r in results:
        c = categories[r["category"]]
        c["total"] += 1
        c["expectations_met"] += not r["differences"]
        c[r["status"]] += 1
    report = {
        "schema": "tespec-executor-e2e/v1",
        "execution_semantics": "inline-preserve/v1",
        "negative_standard": args.negative_standard,
        "binary_sha256": binary_sha256,
        "binary_unchanged": digest(args.binary) == binary_sha256,
        "case_generator_sha256": digest(ROOT / "benchmark/executor_e2e/cases.py"),
        "runner_sha256": digest(Path(__file__)),
        "environment": {
            "python": platform.python_version(),
            "platform": platform.platform(),
            "cc": subprocess.run(
                [args.cc, "--version"], capture_output=True, text=True, check=True
            ).stdout.splitlines()[0],
            "runtime": str(args.runtime.resolve()),
            "jobs": args.jobs,
        },
        "oracle": "functional cases: independent Python results cross-checked against native C; scenarios: explicit semantic expectations",
        "summary": {
            "programs": len({r["program"] for r in inventory}),
            "categories": len(categories),
            "total": len(results),
            "expectations_met": sum(not r["differences"] for r in results),
            "negative_checks": sum(r.get("negative", False) for r in results),
            "false_passes": sum(
                r.get("negative", False) and r["status"] == "PASS" for r in results
            ),
            "negative_resolved": sum(r.get("negative", False) and r["status"] == "FAIL" for r in results),
            "negative_diagnostic_errors": sum(r.get("negative", False) and r["status"] == "ERROR" for r in results),
            "negative_unresolved": sum(r.get("negative", False) and r.get("test_result") == "UNKNOWN" for r in results),
            "native_failures": len(native_failures),
            "verdicts": dict(Counter(r["status"] for r in results)),
            "wall_seconds": round(time.monotonic() - started, 3),
        },
        "categories": dict(categories),
        "native_failures": native_failures,
        "results": results,
    }
    write_json(out / "report.json", report)
    print(json.dumps(report["summary"], ensure_ascii=False))
    return int(
        bool(native_failures)
        or not report["binary_unchanged"]
        or any(r["differences"] for r in results)
    )


if __name__ == "__main__":
    raise SystemExit(main())
