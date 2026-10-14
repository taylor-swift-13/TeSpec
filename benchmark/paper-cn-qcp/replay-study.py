#!/usr/bin/env python3
"""Regenerate a study's VCs and replay reference proofs against exact goals."""

import argparse
import json
from pathlib import Path
import shutil
import subprocess
import sys

from run import HERE, ROOT, read, sha


def command(args, log):
    with log.open("w") as stream:
        result = subprocess.run(args, cwd=ROOT, stdout=stream, stderr=subprocess.STDOUT)
    if result.returncode:
        raise RuntimeError(f"command failed; inspect {log}")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--case", choices=["control_unbounded_root", "cav_simple_power"], required=True
    )
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--timeout", type=int, default=300)
    parser.add_argument(
        "--prepare-only",
        action="store_true",
        help="check exact regenerated goals and stage proofs; do not claim proof completion",
    )
    args = parser.parse_args()
    out = args.output.resolve()
    if out.exists() and any(out.iterdir()):
        parser.error("use a fresh output directory")
    out.mkdir(parents=True, exist_ok=True)
    manifest = read(HERE / "manifest.json")
    entries = manifest["cases"] + manifest["expressibility_items"]
    entry = next(e for e in entries if e["id"] == args.case)
    source = HERE / entry["path"]
    command(
        [
            sys.executable,
            str(HERE / "run.py"),
            "--cases",
            args.case,
            "--tools",
            "qcp",
            "--variants",
            "reference",
            "--output",
            str(out / "automatic"),
        ],
        out / "automatic.log",
    )
    report = out / "automatic" / args.case / "reference/qcp/report.json"
    command(
        [
            sys.executable,
            "-m",
            "spectest",
            "prepare-run-certificates",
            str(report),
            "--output",
            str(out / "proof"),
        ],
        out / "prepare.log",
    )
    prepared = read(out / "prepare.log")
    run_manifest = read(Path(prepared["manifest"]))
    checks = []
    for task in run_manifest["certificates"]:
        original = source / "proofs" / task["case_id"]
        candidate = Path(task["editable"])
        target = read(original / "target.json")
        if sha(candidate.parent / "Goal.v") != target["goal_sha256"]:
            raise RuntimeError(
                "regenerated VC differs from reference: " + task["case_id"]
            )
        if sha(original / "Candidate.v") != target["candidate_sha256"]:
            raise RuntimeError("reference proof hash differs: " + task["case_id"])
        shutil.copy2(original / "Candidate.v", candidate)
        checks.append({"input": task["case_id"], "goal_sha256": target["goal_sha256"]})
    if len(checks) != 4:
        raise RuntimeError("expected all four original VC groups")
    (out / "target-checks.json").write_text(
        json.dumps(
            {"status": "EXACT_GOALS_MATCH", "checks": checks, "proof_completed": False},
            indent=2,
        )
        + "\n"
    )
    if args.prepare_only:
        print("Exact regenerated goals match; proofs staged, not checked.")
        return 0
    command(
        [
            sys.executable,
            "-m",
            "spectest",
            "check-run-certificates",
            prepared["manifest"],
            "--manifest-sha256",
            prepared["manifest_sha256"],
            "--timeout",
            str(args.timeout),
        ],
        out / "check.log",
    )
    completed = read(out / "proof/report.json")
    summary = completed["summary"]
    (out / "summary.json").write_text(json.dumps(summary, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
    return 0 if summary.get("PASS") == 4 else 1


if __name__ == "__main__":
    sys.exit(main())
