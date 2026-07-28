#!/usr/bin/env python3
from __future__ import annotations

import argparse
import json
import math
import os
import subprocess
import sys
import time
from pathlib import Path


PROJECT_ROOT = Path(__file__).resolve().parents[1]
WORKSPACE_ROOT = PROJECT_ROOT.parent

CASES = (
    "sll_head",
    "array_first",
    "array_increment",
    "array_reverse_in_place",
    "array_sum",
    "array_swap_ends",
    "copy_array",
    "array_add",
    "string_first_char",
    "string_set_a",
    "array_find_last_equal",
    "array_prefix_max",
    "array_remove_value_to_output",
    "binary_search",
    "bubble_sort",
    "merge_sorted_arrays",
    "rotate_left_by_one",
    "string_remove_char_to_output",
    "string_reverse_copy",
    "two_sum_sorted",
)


def main() -> int:
    parser = argparse.ArgumentParser(
        description="Run deterministic concrete-memory checks on CAV programs."
    )
    parser.add_argument(
        "--cav-root",
        type=Path,
        default=Path(
            os.environ.get(
                "CAV_BENCH_ROOT",
                str(WORKSPACE_ROOT / "CAV/main/CAV-bench"),
            )
        ),
    )
    parser.add_argument(
        "--output-dir",
        type=Path,
        default=Path(".spectest/cav_memory"),
    )
    parser.add_argument(
        "--max-manual-rate",
        type=float,
        default=0.10,
        help="fail the suite when manual residuals exceed this fraction",
    )
    args = parser.parse_args()
    if not 0 <= args.max_manual_rate <= 1:
        parser.error("--max-manual-rate must be between 0 and 1")

    root = PROJECT_ROOT
    cav_root = args.cav_root.expanduser().resolve()
    output = args.output_dir.expanduser().resolve()
    output.mkdir(parents=True, exist_ok=True)
    reports = []
    started = time.time()
    for name in CASES:
        source = cav_root / "input/algo" / f"{name}.c"
        binds = root / "cases/cav_memory" / f"{name}.binds.json"
        case_output = output / name
        command = [
            sys.executable,
            "-m",
            "spectest",
            "run",
            str(source),
            "--function",
            name,
            "--binds",
            str(binds),
            "--output-dir",
            str(case_output),
            "--loop-unroll-limit",
            "64",
            "--timeout",
            "60",
            "-I",
            "QCP_examples/QCP_demos_LLM",
            "--compact",
        ]
        completed = subprocess.run(
            command,
            cwd=root,
            capture_output=True,
            text=True,
            check=False,
        )
        try:
            report = json.loads(completed.stdout)
        except json.JSONDecodeError:
            report = {
                "schema": "qcp-spectest-suite-case-error/v1",
                "function": name,
                "status": "ERROR",
                "returncode": completed.returncode,
                "stdout": completed.stdout[-4000:],
                "stderr": completed.stderr[-4000:],
            }
        reports.append(report)

    totals = {status: 0 for status in ("PASS", "FAIL", "UNKNOWN", "ERROR")}
    bind_count = 0
    manual_residual_count = 0
    unexpected_unknown_count = 0
    qcp_auto_count = 0
    for report in reports:
        summary = report.get("summary")
        if not isinstance(summary, dict):
            totals["ERROR"] += 1
            bind_count += 1
            continue
        bind_count += int(summary.get("total", 0))
        for status in totals:
            totals[status] += int(summary.get(status, 0))
        for result in report.get("results", []):
            if result.get("reason") == "qcp_full_auto_passed":
                qcp_auto_count += 1
            if result.get("status") != "UNKNOWN":
                continue
            if result.get("reason") == "residual_vc_requires_proof":
                manual_residual_count += 1
            else:
                unexpected_unknown_count += 1
    max_manual_count = math.floor(bind_count * args.max_manual_rate)
    manual_rate = (
        manual_residual_count / bind_count if bind_count else 0.0
    )
    manual_gate_passed = manual_residual_count <= max_manual_count
    suite = {
        "schema": "qcp-spectest-cav-memory-suite/v1",
        "cav_root": str(cav_root),
        "program_count": len(CASES),
        "bind_count": bind_count,
        "summary": {
            **totals,
            "qcp_auto": qcp_auto_count,
            "manual_residual": manual_residual_count,
            "manual_rate": round(manual_rate, 6),
            "unexpected_unknown": unexpected_unknown_count,
            "duration_seconds": round(time.time() - started, 6),
        },
        "manual_gate": {
            "max_rate": args.max_manual_rate,
            "max_count": max_manual_count,
            "actual_count": manual_residual_count,
            "actual_rate": round(manual_rate, 6),
            "passed": manual_gate_passed,
        },
        "reports": reports,
    }
    report_path = output / "suite-report.json"
    report_path.write_text(
        json.dumps(suite, ensure_ascii=False, indent=2) + "\n",
        encoding="utf-8",
    )
    print(json.dumps(suite, ensure_ascii=False, indent=2))
    return (
        0
        if (
            totals["FAIL"] == 0
            and totals["ERROR"] == 0
            and unexpected_unknown_count == 0
            and manual_gate_passed
            and totals["PASS"] + manual_residual_count == bind_count
        )
        else 1
    )


if __name__ == "__main__":
    raise SystemExit(main())
