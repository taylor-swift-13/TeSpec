#!/usr/bin/env python3
"""Audit the published artifact's trial CSV without treating it as replay evidence."""

import argparse
from collections import Counter
import csv
import hashlib
import json
import math
from pathlib import Path


def analyze(catalog, rows):
    selected = {p["path"]: p for p in catalog if p.get("found") is True}
    if len(selected) != sum(p.get("found") is True for p in catalog):
        raise ValueError("duplicate selected patch")
    expected = {
        (path, trial)
        for path in selected
        for trial in range(1, (50 if "patch-10-" in path else 10) + 1)
    }
    seen = set()
    grouped = {path: [] for path in selected}
    for row in rows:
        key = row["patch"], int(row["trial_num"])
        if key in seen:
            raise ValueError("duplicate trial")
        if key not in expected:
            raise ValueError("unexpected patch or trial")
        if row["function"] != selected[key[0]]["fut"]:
            raise ValueError("function does not match catalog")
        if row["bug_found"] not in ("True", "False"):
            raise ValueError("invalid bug_found value")
        elapsed = float(row["elapsed_time"])
        if not math.isfinite(elapsed) or elapsed < 0:
            raise ValueError("invalid elapsed_time")
        for column in ("num_runs", "num_discards"):
            if row[column] and int(row[column]) < 0:
                raise ValueError("negative " + column)
        seen.add(key)
        grouped[key[0]].append(row)
    by_patch = []
    for path, patch in selected.items():
        trials = grouped[path]
        found = sum(row["bug_found"] == "True" for row in trials)
        by_patch.append(
            {
                "patch": path,
                "function": patch["fut"],
                "expected_trials": 50 if "patch-10-" in path else 10,
                "observed_trials": len(trials),
                "reported_detections": found,
                "reported_non_detections": len(trials) - found,
                "trial_wall_seconds": sum(float(row["elapsed_time"]) for row in trials),
            }
        )
    functions = Counter(p["fut"] for p in selected.values())
    return {
        "scope": "author CSV reports; no per-trial log attribution or counterexample replay",
        "complete": seen == expected,
        "selected_patches": len(selected),
        "excluded_catalog_patches": len(catalog) - len(selected),
        "expected_trials": len(expected),
        "observed_trials": len(seen),
        "missing_trials": len(expected - seen),
        "reported_detections": sum(p["reported_detections"] for p in by_patch),
        "repeated_function_names": {k: v for k, v in functions.items() if v > 1},
        "non_detection_meaning": "CSV does not distinguish timeout, generation failure, and sample completion",
        "log_identity": "function_trialN.log omits patch and mode; original collector overwrites collisions",
        "patches": by_patch,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--catalog", type=Path, required=True)
    parser.add_argument("--csv", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    if args.output.exists():
        parser.error("output already exists")
    # Snapshot each input once so hashes identify the exact bytes analyzed,
    # even when an explicitly partial observation is taken during a live run.
    catalog_data, csv_data = args.catalog.read_bytes(), args.csv.read_bytes()
    report = analyze(
        json.loads(catalog_data), list(csv.DictReader(csv_data.decode().splitlines()))
    )
    report["inputs"] = {
        "catalog_sha256": hashlib.sha256(catalog_data).hexdigest(),
        "csv_sha256": hashlib.sha256(csv_data).hexdigest(),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(
        json.dumps(
            {k: report[k] for k in ("complete", "observed_trials", "expected_trials")}
        )
    )


if __name__ == "__main__":
    main()
