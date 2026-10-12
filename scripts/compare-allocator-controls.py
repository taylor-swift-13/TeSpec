#!/usr/bin/env python3
"""Pair original allocator bug probes with their patch-reversed controls."""

import argparse
from collections import Counter
import hashlib
import json
from pathlib import Path


def pair_runs(buggy, controls, buggy_analysis, control_analysis):
    for key in [
        "source_revision",
        "catalog_sha256",
        "switch",
        "samples",
        "trials",
        "timeout_seconds",
        "selected_cases",
        "seed_policy",
    ]:
        if buggy[key] != controls[key]:
            raise ValueError("incompatible probe configuration: " + key)
    if buggy.get("variant", "buggy") != "buggy" or controls["variant"] != "correct":
        raise ValueError("expected buggy and correct probe reports")

    def index(analysis):
        result = {}
        for row in analysis["runs"]:
            key = (row["case"], row["engine"], row["trial"])
            if key in result:
                raise ValueError("duplicate analyzed run")
            result[key] = row
        return result

    left, right = index(buggy_analysis), index(control_analysis)
    raw_left, raw_right = index(buggy), index(controls)
    engines = sorted(set(buggy["engines"]) & set(controls["engines"]))
    rows = []
    for case in buggy["selected_cases"]:
        for engine in engines:
            for trial in range(buggy["trials"]):
                key = (case, engine, trial)
                a, b = left.get(key), right.get(key)
                if a is not None and b is not None:
                    for field in ("seed", "command", "entry"):
                        if raw_left[key][field] != raw_right[key][field]:
                            raise ValueError("paired run differs in " + field)
                if a is None or b is None:
                    status = "MISSING_PAIR"
                elif b["status"] != "SAMPLES_PASSED":
                    status = "CONTROL_NOT_PASSED"
                elif a["status"] in {
                    "TEST_FAILURE_REPORTED",
                    "COUNTEREXAMPLE_REPORTED",
                }:
                    status = "FAILURE_WITH_PASSING_CONTROL"
                elif a["status"] == "SAMPLES_PASSED":
                    status = "BOTH_SAMPLES_PASSED"
                else:
                    status = "BUGGY_RUN_INCONCLUSIVE"
                rows.append(
                    {
                        "case": case,
                        "engine": engine,
                        "trial": trial,
                        "status": status,
                        "buggy": a,
                        "control": b,
                    }
                )
    return rows


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--buggy-report", type=Path, required=True)
    parser.add_argument("--control-report", type=Path, required=True)
    parser.add_argument("--buggy-analysis", type=Path, required=True)
    parser.add_argument("--control-analysis", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    inputs = {}
    hashes = {}
    for name in (
        "buggy_report",
        "control_report",
        "buggy_analysis",
        "control_analysis",
    ):
        data = getattr(args, name).read_bytes()
        hashes[name] = hashlib.sha256(data).hexdigest()
        inputs[name] = json.loads(data)
    for variant in ("buggy", "control"):
        if (
            inputs[variant + "_analysis"]["original_report_sha256"]
            != hashes[variant + "_report"]
        ):
            raise ValueError("analysis does not match original report: " + variant)
    rows = pair_runs(
        inputs["buggy_report"],
        inputs["control_report"],
        inputs["buggy_analysis"],
        inputs["control_analysis"],
    )
    result = {
        "scope": "paired-subject-controls-inventory-probe",
        "input_note": "same seed and generation budget; mutated predicates can generate different concrete inputs",
        "witness_note": "failure summaries are not promoted to archived concrete counterexamples",
        "input_hashes": hashes,
        "summary": dict(Counter(row["status"] for row in rows)),
        "runs": rows,
    }
    if args.output.exists():
        parser.error("output already exists")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result["summary"], indent=2))


if __name__ == "__main__":
    main()
