#!/usr/bin/env python3
"""Classify retained allocator logs without changing the original run record."""

import argparse
from collections import Counter
import csv
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "allocator", ROOT / "scripts/run-allocator-baseline.py"
)
allocator = importlib.util.module_from_spec(spec)
spec.loader.exec_module(allocator)


def inventory_complete(original, rows):
    expected = {
        (case, engine, trial)
        for case in original["selected_cases"]
        for engine in original["engines"]
        for trial in range(original["trials"])
    }
    actual = [(row["case"], row["engine"], row["trial"]) for row in rows]
    return (
        len(actual) == len(expected)
        and set(actual) == expected
        and not any(row["status"] == "SETUP_ERROR" for row in rows)
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("report", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument(
        "--log-dir",
        type=Path,
        help="portable directory containing archived case-NN-engine-trial.txt.gz logs",
    )
    args = parser.parse_args()
    if args.output.exists() and any(args.output.iterdir()):
        parser.error("output must be empty")
    report_bytes = args.report.read_bytes()
    original = json.loads(report_bytes)
    rows = []
    for run in original["runs"]:
        if run["status"] == "SETUP_ERROR":
            rows.append(
                {
                    "case": run["case"],
                    "engine": None,
                    "trial": None,
                    "status": "SETUP_ERROR",
                }
            )
            continue
        if args.log_dir:
            log = gzip.decompress(
                (
                    args.log_dir
                    / f"case-{run['case']:02d}-{run['engine']}-{run['trial']}.txt.gz"
                ).read_bytes()
            )
        else:
            log = Path(run["log"]).read_bytes()
        if hashlib.sha256(log).hexdigest() != run["log_sha256"]:
            raise ValueError("recorded log hash differs: " + run["log"])
        rows.append(
            {
                "case": run["case"],
                "engine": run["engine"],
                "trial": run["trial"],
                "status": allocator.classify(
                    run["returncode"], log.decode(errors="replace")
                ),
                "original_status": run["status"],
                "wall_seconds": run["wall_seconds"],
                "log": run["log"],
                "log_sha256": run["log_sha256"],
            }
        )
    expected = (
        len(original["selected_cases"]) * len(original["engines"]) * original["trials"]
    )
    grouped = {
        engine: dict(Counter(row["status"] for row in rows if row["engine"] == engine))
        for engine in original["engines"]
    }
    result = {
        "scope": original["scope"],
        "original_report_sha256": hashlib.sha256(report_bytes).hexdigest(),
        "classifier_sha256": allocator.comparison.sha(Path(allocator.__file__)),
        "recorded_runs": len(rows),
        "planned_runs": expected,
        "complete_inventory": inventory_complete(original, rows),
        "per_engine": grouped,
        "runs": rows,
    }
    args.output.mkdir(parents=True, exist_ok=True)
    (args.output / "analysis.json").write_text(json.dumps(result, indent=2) + "\n")
    fields = [
        "case",
        "engine",
        "trial",
        "status",
        "original_status",
        "wall_seconds",
        "log",
        "log_sha256",
    ]
    with (args.output / "runs.csv").open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=fields)
        writer.writeheader()
        writer.writerows(rows)
    table = [
        r"\begin{tabular}{lrrrrrr}",
        r"\toprule",
        r"Generator & Failures & Passed & Gen. failed & Timeout & Other & Total\\",
        r"\midrule",
    ]
    for engine, counts in grouped.items():
        failures = counts.get("TEST_FAILURE_REPORTED", 0) + counts.get(
            "COUNTEREXAMPLE_REPORTED", 0
        )
        passed = counts.get("SAMPLES_PASSED", 0)
        failed_gen = counts.get("GENERATION_FAILED", 0)
        timeout = counts.get("TIMEOUT", 0)
        total = sum(counts.values())
        other = total - failures - passed - failed_gen - timeout
        table.append(
            f"{engine.capitalize()} & {failures} & {passed} & {failed_gen} & {timeout} & {other} & {total}"
            + r"\\"
        )
    table.extend([r"\bottomrule", r"\end{tabular}"])
    (args.output / "summary.tex").write_text("\n".join(table) + "\n")
    print(json.dumps({k: v for k, v in result.items() if k != "runs"}, indent=2))


if __name__ == "__main__":
    main()
