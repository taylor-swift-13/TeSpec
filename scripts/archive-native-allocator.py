#!/usr/bin/env python3
"""Validate and archive the original allocator's staged native experiments."""

import argparse
from collections import Counter
import csv
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location(
    "native", ROOT / "scripts/run-fulminate-allocator.py"
)
native = importlib.util.module_from_spec(spec)
spec.loader.exec_module(native)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def analyze(report, read_log):
    selected = report["selected_cases"]
    cases = [row["case"] for row in report["runs"]]
    if len(cases) != len(set(cases)) or sorted(cases) != sorted(selected):
        raise ValueError("missing or duplicate cases")
    rows = []
    for run in report["runs"]:
        stages = run["stages"]
        expected = ["checkout", "patch"]
        if run["case"] == 0:
            expected.append("control")
        expected += ["preprocess", "instrument", "build", "execution"]
        names = [stage["stage"] for stage in stages]
        if not names or names != expected[: len(names)]:
            raise ValueError("unexpected stage sequence")
        if any(stage["returncode"] != 0 for stage in stages[:-1]):
            raise ValueError("run continued after failed stage")
        if len(names) != len(expected) and stages[-1]["returncode"] == 0:
            raise ValueError("incomplete successful prefix")
        logs = []
        for stage in stages:
            data = read_log(stage)
            if sha(data) != stage["log_sha256"]:
                raise ValueError("log hash mismatch")
            logs.append(data.decode(errors="replace"))
        last = stages[-1]
        status = native.native_outcome(last["stage"], last["returncode"], logs[-1])
        if status != run["status"]:
            raise ValueError("recorded classification mismatch")
        location = re.search(
            r"function ([^,\n]+), file ([^,\n]+), line (\d+)", logs[-1]
        )
        rows.append(
            {
                "case": run["case"],
                "is_control": run["case"] == 0,
                "status": status,
                "terminal_stage": last["stage"],
                "runtime_failure_function": location[1] if location else None,
                "wall_seconds_all_stages": sum(s["wall_seconds"] for s in stages),
                "execution_wall_seconds": last["wall_seconds"]
                if last["stage"] == "execution"
                else None,
            }
        )
    return {
        "scope": report["scope"],
        "inventory_complete": True,
        "control_counts": dict(Counter(r["status"] for r in rows if r["is_control"])),
        "subject_counts": dict(
            Counter(r["status"] for r in rows if not r["is_control"])
        ),
        "runs": rows,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("run", type=Path)
    parser.add_argument("--output", required=True, type=Path)
    args = parser.parse_args()
    source, out = args.run.resolve(), args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("output must be empty")
    report = json.loads((source / "report.json").read_text())
    catalog = (source / "catalog.json").read_bytes()
    driver = (source / "executed-driver.py.txt").read_bytes()
    if (
        sha(catalog) != report["catalog_sha256"]
        or sha(driver) != report["driver_sha256"]
    ):
        raise ValueError("catalog or executed driver differs from report")
    if set(report["selected_cases"]) != set(range(len(json.loads(catalog)) + 1)):
        raise ValueError("report does not cover full catalog plus control")
    analysis = analyze(report, lambda stage: Path(stage["log"]).read_bytes())
    out.mkdir(parents=True, exist_ok=True)
    files = [
        source / n for n in ["report.json", "catalog.json", "executed-driver.py.txt"]
    ]
    files += [
        Path(stage["log"]).resolve()
        for row in report["runs"]
        for stage in row["stages"]
    ]
    index = []
    for path in files:
        relative = path.relative_to(source)
        data = path.read_bytes()
        compressed = path.suffix == ".log"
        if compressed:
            relative = relative.with_suffix(".log.gz")
        target = out / relative
        target.parent.mkdir(parents=True, exist_ok=True)
        stored = gzip.compress(data, mtime=0) if compressed else data
        target.write_bytes(stored)
        index.append(
            {
                "file": str(relative),
                "sha256": sha(stored),
                "uncompressed_sha256": sha(data),
            }
        )
    (out / "archive.json").write_text(json.dumps({"files": index}, indent=2) + "\n")
    (out / "analysis.json").write_text(json.dumps(analysis, indent=2) + "\n")
    with (out / "cases.csv").open("w") as handle:
        writer = csv.DictWriter(handle, fieldnames=list(analysis["runs"][0]))
        writer.writeheader()
        writer.writerows(analysis["runs"])
    print(json.dumps({k: v for k, v in analysis.items() if k != "runs"}, indent=2))


if __name__ == "__main__":
    main()
