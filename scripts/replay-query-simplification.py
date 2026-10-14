#!/usr/bin/env python3
"""Replay frozen query-simplification regressions against an explicit binary."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from spectest.core import run_job  # noqa: E402

MANIFEST = ROOT / "tests/fixtures/query_simplification/cases.json"
MODES = ("entry-exit", "all-boundaries")


def load_cases(selected=None):
    cases = json.loads(MANIFEST.read_text())["cases"]
    missing = set(selected or ()) - {case["id"] for case in cases}
    if missing:
        raise ValueError("Unknown cases: " + ", ".join(sorted(missing)))
    cases = [c for c in cases if not selected or c["id"] in selected]
    for case in cases:
        actual = hashlib.sha256((ROOT / case["source"]).read_bytes()).hexdigest()
        if actual != case["source_sha256"]:
            raise ValueError("Frozen source hash mismatch: " + case["source"])
    return cases


def expectations_met(case, mode, row):
    status = case.get("expect_status_by_mode", {}).get(mode, case.get("expect_status"))
    checks = []
    if status is not None:
        checks.append(row["status"] == status)
    if "expect_reason" in case:
        checks.append(row["reason"] == case["expect_reason"])
    if "expect_execution" in case:
        checks.append(
            (row.get("phases") or {}).get("execution") == case["expect_execution"]
        )
    return all(checks) if checks else None


def replay(binary, output, cases, modes=MODES):
    binary = Path(binary).resolve(strict=True)
    output = Path(output).resolve()
    binary_hash = hashlib.sha256(binary.read_bytes()).hexdigest()
    output.mkdir(parents=True, exist_ok=False)
    options = {
        "timeout_seconds": 8,
        "loop_unroll_limit": 8,
        "call_depth_limit": 16,
        "instance_trace": True,
    }
    report = {
        "schema": "tespec-query-simplification-replay/v1",
        "binary_sha256": binary_hash,
        "manifest_sha256": hashlib.sha256(MANIFEST.read_bytes()).hexdigest(),
        "options": options,
        "runs": [],
    }
    for case in cases:
        for mode in modes:
            dest = output / case["id"] / mode
            dest.mkdir(parents=True)
            binding = dict(case["bind"])
            if case.get("spec"):
                binding["spec"] = case["spec"]
            execution_options = {**options, **case.get("execution_options", {})}
            job = {
                "source": str(ROOT / case["source"]),
                "function": case["function"],
                "binds": [binding],
                "qcp": {
                    "binary": str(binary),
                    "qcip_root": str(ROOT / "runtime/qcip"),
                    "execution_mode": mode,
                    **execution_options,
                    "include_dirs": [
                        str(ROOT / d) for d in case.get("include_dirs", [])
                    ],
                },
            }
            job_path = dest / "job.json"
            job_path.write_text(json.dumps(job, indent=2) + "\n")
            result = run_job(job_path, dest / "result")["results"][0]
            row = {
                "case": case["id"],
                "mode": mode,
                "execution_options": execution_options,
                **{
                    k: result.get(k)
                    for k in (
                        "status",
                        "reason",
                        "phases",
                        "execution_completed",
                        "executor_error",
                    )
                },
            }
            row["return_vc_statuses"] = [
                v["status"]
                for v in result.get("vc_results", [])
                if v["kind"] == "return"
            ]
            row["expectations_met"] = expectations_met(case, mode, row)
            row["known_limit"] = case.get("known_limit", False)
            report["runs"].append(row)
            (output / "summary.json").write_text(json.dumps(report, indent=2) + "\n")
            print(
                json.dumps(
                    {
                        k: row[k]
                        for k in (
                            "case",
                            "mode",
                            "status",
                            "reason",
                            "expectations_met",
                        )
                    }
                ),
                flush=True,
            )
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--binary", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--case", action="append")
    parser.add_argument("--mode", action="append", choices=MODES)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    try:
        cases = load_cases(args.case)
    except ValueError as error:
        parser.error(str(error))
    report = replay(args.binary, args.output, cases, args.mode or MODES)
    return int(
        args.check and any(r["expectations_met"] is False for r in report["runs"])
    )


if __name__ == "__main__":
    raise SystemExit(main())
