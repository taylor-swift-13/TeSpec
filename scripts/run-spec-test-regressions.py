#!/usr/bin/env python3
"""Paired semantic expectations, separate from generated corpus smoke inputs."""

from __future__ import annotations

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from spectest.core import bundled_qcp_binary, run_job  # noqa: E402


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--examples", type=Path, required=True)
    parser.add_argument("--binary", type=Path, default=bundled_qcp_binary())
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--dataset", type=Path, default=ROOT / "benchmark/spec-test-qcp-cases.json"
    )
    args = parser.parse_args()
    dataset = json.loads(args.dataset.read_text())
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=True)
    results = []
    for index, entry in enumerate(dataset["jobs"]):
        for mode in ("expand", "no-expand"):
            directory = output / "artifacts" / f"{index:03d}" / mode
            directory.mkdir(parents=True, exist_ok=True)
            source = args.examples.resolve() / entry["source"]
            job = {
                "source": str(source),
                "function": entry["function"],
                "spec": entry.get("spec"),
                "binds": [
                    {key: value for key, value in case.items() if key != "expected"}
                    for case in entry["binds"]
                ],
                "qcp": {
                    "binary": str(args.binary.resolve()),
                    "qcip_root": str(args.examples.resolve().parent),
                    "execution_mode": mode,
                    "timeout_seconds": 10,
                },
            }
            path = directory / "job.json"
            path.write_text(json.dumps(job, indent=2) + "\n")
            report = run_job(path, directory)
            for specification, actual in zip(
                entry["binds"], report["results"], strict=True
            ):
                expected = specification["expected"][mode]
                observed = {
                    **actual.get("phases", {}),
                    "overall": actual["overall"],
                    "scope": actual.get("scope"),
                }
                differences = {
                    key: {"expected": value, "actual": observed.get(key)}
                    for key, value in expected.items()
                    if observed.get(key) != value
                }
                results.append(
                    {
                        "source": entry["source"],
                        "function": entry["function"],
                        "case": actual["id"],
                        "mode": mode,
                        "observed": observed,
                        "differences": differences,
                        "report": report["report"],
                    }
                )
    final = {
        "schema": "tespec-curated-report/v1",
        "binary_sha256": hashlib.sha256(args.binary.read_bytes()).hexdigest(),
        "dataset_sha256": hashlib.sha256(args.dataset.read_bytes()).hexdigest(),
        "summary": {
            "total": len(results),
            "expectations_met": sum(not r["differences"] for r in results),
            "verdicts": dict(Counter(r["observed"]["overall"] for r in results)),
        },
        "limitations": dataset.get("limitations", []),
        "results": results,
    }
    (output / "report.json").write_text(json.dumps(final, indent=2) + "\n")
    print(json.dumps(final["summary"]))
    return int(any(r["differences"] for r in results))


if __name__ == "__main__":
    raise SystemExit(main())
