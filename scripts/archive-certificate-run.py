#!/usr/bin/env python3
"""Archive a completed proof replay's evidence without its runtime libraries."""

import argparse
import gzip
import hashlib
import json
from pathlib import Path


def sha(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("run", type=Path)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    source = args.run.resolve()
    output = args.output.resolve()
    if output.exists() and any(output.iterdir()):
        parser.error("output must be empty")
    report_bytes = (source / "certificate-report.json").read_bytes()
    report = json.loads(report_bytes)
    for filename, key in [
        ("manifest.json", "manifest_sha256"),
        ("Candidate.v", "candidate_sha256"),
        ("Goal.v", "original_goal_sha256"),
    ]:
        if sha((source / filename).read_bytes()) != report[key]:
            raise ValueError("proof source differs from checked report: " + filename)
    sources = [
        source / name
        for name in [
            "manifest.json",
            "certificate-report.json",
            "Candidate.v",
            "Goal.v",
            "Coverage.v",
            "Assumptions.v",
            "AssumptionIdentities.v",
        ]
        if (source / name).is_file()
    ]
    manifest = json.loads((source / "manifest.json").read_text())
    for name, expected in manifest["immutable_sha256"].items():
        path = source / name
        if Path(name).name != name or sha(path.read_bytes()) != expected:
            raise ValueError("immutable certificate input changed: " + name)
        if path not in sources:
            sources.append(path)
    sources.extend(sorted((source / "dependencies").rglob("*.v")))
    sources.extend(Path(stage["log"]).resolve() for stage in report["stages"])
    records = []
    output.mkdir(parents=True, exist_ok=True)
    for path in sources:
        # Keep the archived dependency closure local to the proof run.
        relative = path.resolve().relative_to(source)
        data = path.read_bytes()
        compressed = path.suffix == ".log"
        destination = output / relative
        if compressed:
            destination = destination.with_suffix(".log.gz")
        stored = gzip.compress(data, mtime=0) if compressed else data
        destination.parent.mkdir(parents=True, exist_ok=True)
        destination.write_bytes(stored)
        records.append(
            {
                "file": str(destination.relative_to(output)),
                "sha256": sha(stored),
                "uncompressed_sha256": sha(data),
                "encoding": "gzip" if compressed else "identity",
            }
        )
    index = {
        "schema": "tespec-certificate-evidence-archive/v1",
        "status": report["status"],
        "scope": report["scope"],
        "original_report_sha256": sha(report_bytes),
        "reproduction": (
            "regenerate with scripts/prepare-predicate-normalization.py; runtime is pinned in manifest.json"
            if report["scope"] == "predicate-normalization-equations"
            else "regenerate with scripts/replay-certificate-case.py; runtime is pinned in manifest.json"
        ),
        "files": records,
    }
    (output / "archive.json").write_text(json.dumps(index, indent=2) + "\n")
    print(json.dumps({"status": report["status"], "files": len(records)}))


if __name__ == "__main__":
    main()
