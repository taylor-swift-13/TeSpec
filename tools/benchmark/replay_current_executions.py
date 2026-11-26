#!/usr/bin/env python3
"""Recheck available proof sources against each frozen, residual execution."""
import argparse
from collections import defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import shutil
import subprocess
import sys

from organize_tespec_routes import ROOT, RESULTS, read, fingerprint
from spectest.run_certificates import prepare_run_certificates
from spectest.proof_reuse import proof_key


def candidate_index(base):
    index = defaultdict(list)
    for candidate in sorted(base.rglob("Candidate.v")):
        for name in ("Goal.v", "ExecutionGoal.v"):
            goal = candidate.with_name(name)
            if goal.is_file():
                index[fingerprint(goal)].append(candidate)
                break
    for receipt in sorted((base / "evidence/proofs").rglob("*.json")):
        proof = read(receipt)
        if proof.get("kind") == "test" and proof.get("globally_closed") and proof.get("status") == "PASS":
            path = ROOT / proof["candidate"]["path"]
            if path.is_file() and fingerprint(path) == proof["candidate"]["sha256"]:
                index[proof["goal"]["sha256"]].append(path)
    return index


def run_group(group, scratch, pool):
    base = RESULTS / group
    index = candidate_index(base)
    def run(row):
        if row["auto_status"] == "NOT_RUN":
            return
        folder = scratch / row["native_report_sha256"]
        native = folder / "out/native/report.json"
        out = folder / "current-itp"
        if out.exists():
            return
        if fingerprint(native) != row["native_report_sha256"]:
            raise ValueError("Changed frozen native report")
        cache = folder / "replay-source"
        cache.mkdir(exist_ok=True)
        prepared = folder / "candidate-staging"
        if not prepared.exists():
            prepare_run_certificates(native, prepared, decision_only=True)
        bundle = read(prepared / "case_0000/manifest.json")
        report = read(native)
        key = proof_key(bundle, report, report["results"][0])
        if key:
            cached = ROOT / ".spectest/proof-cache" / (key + ".v")
            candidates = ([cached] if cached.is_file() else []) + index.get(bundle["original_goal_sha256"], [])
            if candidates:
                shutil.copyfile(candidates[0], cache / (key + ".v"))
        proc = subprocess.run([sys.executable, "-B", "-m", "spectest", "routes", "--native-report", str(native),
                               "--route", "itp", "--itp-replay-only", "--proof-cache", str(cache),
                               "--output-dir", str(out)], cwd=ROOT, capture_output=True, text=True)
        if not (out / "routes.json").is_file():
            raise RuntimeError(proc.stderr[-1000:])
    rows = read(base / "tespec/current-executions.json")["executions"]
    for _ in pool.map(run, rows):
        pass
    print(group, sum(r["auto_status"] != "NOT_RUN" for r in rows), flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--group", action="append")
    parser.add_argument("--workers", type=int, default=1)
    args = parser.parse_args()
    groups = args.group or sorted(p.parent.parent.name for p in RESULTS.glob("*/tespec/current-executions.json"))
    with ThreadPoolExecutor(args.workers) as pool:
        for group in groups:
            run_group(group, args.scratch, pool)


if __name__ == "__main__":
    main()
