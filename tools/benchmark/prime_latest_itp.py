#!/usr/bin/env python3
"""Prime the new per-input ITP queue by supplying historical positive Coq sources only."""
import argparse
import os
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import re
import shutil
import subprocess
import sys

from organize_tespec_routes import ROOT, RESULTS, read, save, fingerprint
from spectest.proof_reuse import proof_key
from replay_source_only_itp import run_replay


def historical_positive_sources(old_scratch):
    found = {}
    for index in sorted(RESULTS.glob("*/tespec/current-itp.json")):
        for native_sha, row in read(index)["executions"].items():
            folder = old_scratch / native_sha
            native = folder / "out/native/report.json"
            if fingerprint(native) != native_sha:
                raise ValueError(f"old native report differs in {folder}")
            original = read(native)
            case, = original["results"]
            for manifest in folder.glob("*/itp/*proof/case_*/manifest.json"):
                audit = manifest.with_name("certificate-report.json")
                source = manifest.with_name("Candidate.v")
                if not audit.is_file() or not source.is_file():
                    continue
                bundle = read(manifest)
                check = read(audit)
                if bundle.get("refuted_goal") or check.get("polarity") == "negative":
                    continue
                if check.get("manifest_sha256") != fingerprint(manifest) or check["candidate_sha256"] != fingerprint(source):
                    continue
                if check.get("proof_status") != "VALID" and re.search(r"\b(?:Abort|Admitted)\s*\.|\badmit\b", source.read_text()):
                    continue
                key = proof_key(bundle, original, case)
                if key:
                    rank = (check.get("proof_status") == "VALID", check.get("status") == "PASS")
                    if key not in found or rank > found[key][0]:
                        found[key] = rank, source
    return found


def initial(row, scratch, cache):
    target = scratch / row["native_report_sha256"]
    native = target / "out/native/report.json"
    if fingerprint(native) != target.name:
        raise ValueError(f"different original projection for {target}")
    out = target / "current-itp"
    if not (out / "routes.json").is_file():
        if out.exists():
            raise ValueError(f"interrupted replay in {out}")
        cmd = [sys.executable, "-B", "-m", "spectest", "routes", "--native-report", str(native),
               "--route", "itp", "--itp-replay-only", "--proof-cache", str(cache), "--output-dir", str(out)]
        proc = subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True)
        if not (out / "routes.json").is_file():
            raise RuntimeError(f"{target.name}: {proc.stderr[-900:]}")
    result = read(out / "routes.json")
    case, = result["cases"]
    if (result["native_report_sha256"] != target.name or case["case_id"] != row["executor_case_id"]
            or not case["eligible"] or result["routes"]["itp"].get("model_calls") != 0):
        raise ValueError(f"invalid initial replay in {out}")
    return row["group"], case["itp_status"]


def missing_refresh(row, scratch, cache):
    folder = scratch / row["native_report_sha256"]
    first = folder / "current-itp"
    if not (first / "routes.json").is_file():
        return None
    native = folder / "out/native/report.json"
    report = read(native)
    case, = report["results"]
    bundle, = first.glob("itp/proof/case_*/manifest.json")
    key = proof_key(read(bundle), report, case)
    candidate = cache / (key + ".v") if key else None
    if candidate is None or not candidate.is_file():
        return None
    sha = fingerprint(candidate)
    if any(read(p).get("candidate_sha256") == sha for p in first.glob("**/certificate-report.json")):
        return None
    return folder, native, candidate, key, "peer-positive-replay-" + sha


def main():
    par=argparse.ArgumentParser(description=__doc__)
    par.add_argument("--scratch", required=True, type=Path)
    par.add_argument("--old-scratch", required=True, type=Path)
    par.add_argument("--workers", type=int, default=3)
    par.add_argument("--refresh-sources-only", action="store_true")
    par.add_argument("--replay-refreshed", action="store_true", help="Replay sources supplied after initial cache preparation")
    par.add_argument("--prime-no-candidate", action="store_true")
    args=par.parse_args()
    slots=args.scratch/"resource-slots"
    slots.mkdir(exist_ok=True)
    os.environ.setdefault("TESPEC_ITP_RESOURCE_DIR", str(slots.resolve()))
    queue=read(args.scratch/"queue.json")["executions"]
    cache=args.scratch/"historical-positive-sources"
    cache.mkdir(exist_ok=True)
    sources=historical_positive_sources(args.old_scratch)
    for key, (_, candidate) in sources.items():
        item=cache/(key+".v")
        if not item.exists() or fingerprint(item)!=fingerprint(candidate):
            shutil.copyfile(candidate, item)
    print("Strict proof keys with historical candidate sources",len(sources), flush=True)
    if args.refresh_sources_only:
        return
    if args.replay_refreshed:
        tasks = [task for row in queue if (task := missing_refresh(row,args.scratch,cache))]
        print("Supplemental historical candidates",len(tasks),flush=True)
        with ThreadPoolExecutor(args.workers) as pool:
            for data in pool.map(lambda t:run_replay(*t),tasks):
                print(data["native_report_sha256"],data["cases"][0]["itp_status"],flush=True)
        return
    # Prime wholly new goals first. These fast misses expose manifests for the
    # metered pool while independent checked historical sources are recompiled.
    old_goals={r["goal_sha256"] for index in RESULTS.glob("*/tespec/current-itp.json")
               for r in read(index)["executions"].values()}
    source_goals = {read(source.with_name("manifest.json"))["original_goal_sha256"] for _,source in sources.values()}
    queue=sorted(queue,key=lambda r: (r["goal_sha256"] in old_goals, r["goal_sha256"] in source_goals))
    if args.prime_no_candidate:
        queue = [r for r in queue if r["goal_sha256"] in old_goals and r["goal_sha256"] not in source_goals]
        queue = [r for r in queue if not (args.scratch/r["native_report_sha256"]/"current-itp").exists()]
    from collections import Counter
    total=Counter()
    with ThreadPoolExecutor(args.workers) as pool:
        for i, (group,status) in enumerate(pool.map(lambda row:initial(row,args.scratch,cache),queue),1):
            total[status]+=1
            if i%25==0:print(i,group,dict(total),flush=True)
    if args.prime_no_candidate:
        save(args.scratch/"ready-safe.json",{"scope":"initial replay complete, no complete prior positive source for this original goal; check negative plan separately",
             "native_report_sha256":[r["native_report_sha256"] for r in queue]})
    print("Completed initial replays",dict(total),flush=True)


if __name__=="__main__":
    main()
