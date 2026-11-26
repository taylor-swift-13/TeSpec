#!/usr/bin/env python3
"""Remeasure only Auto on the published native residuals and gate previously correct cases."""
import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import subprocess
import sys
from tempfile import TemporaryDirectory

from organize_tespec_routes import ROOT, RESULTS, digest, fingerprint, read, save
from current_test_plan import matches_crash


def replay(row, scratch):
    native = scratch / row["native_report_sha256"] / "out/native/report.json"
    if fingerprint(native) != row["native_report_sha256"]:
        raise ValueError("Native report changed")
    with TemporaryDirectory() as tmp:
        out = Path(tmp)
        proc = subprocess.run([sys.executable, "-B", "-m", "spectest", "routes", "--route", "auto",
                               "--native-report", str(native), "--output-dir", str(out)], cwd=ROOT, capture_output=True, text=True)
        if proc.returncode != 0:
            raise RuntimeError(proc.stderr[-1200:])
        routes = read(out / "routes.json")
        c, = routes["cases"]
        result, = read(out / "auto/report.json")["results"]
        if (not c["eligible"] or c["case_id"] != row["executor_case_id"] or
                c["native_status"] != row["native_status"] or routes["native_report_sha256"] != row["native_report_sha256"]):
            raise ValueError("Execution identity changed")
        m = routes["routes"]["auto"]
        if m["model_calls"] != 0 or m["tokens"] != 0:
            raise ValueError("Model used on Auto")
        status = c["auto_status"]
        return dict(auto_status=status, effective_status=status, expected_match=(status == row["expected"] and
                    (status != "CRASH" or matches_crash(result,row["expected_fault_code"]))),
                    reason=result.get("reason"), auto={key:m[key] for key in ("wall_seconds","max_process_rss_kib","model_calls","tokens","status")}
                    | {"report_sha256":fingerprint(out/"auto/report.json")},
                    auto_diagnostic={"entry": (result.get("auto_route",{}).get("entry") or {}).get("reason"),
                                     "records": sorted({s.get("reason") for s in result.get("auto_route",{}).get("results",[]) if s.get("reason")})})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch",type=Path,required=True)
    parser.add_argument("--workers",type=int,default=2)
    args=parser.parse_args()
    source_dirs=[ROOT/"spectest",ROOT/"tools/finite_spatial_smt"]
    impl=digest({str(p.relative_to(ROOT)):fingerprint(p) for d in source_dirs for p in sorted(d.glob("*.py"))})
    groups={}
    jobs=[]
    for path in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        data=read(path)
        for r in data["executions"]:
            if r["auto_status"] != "NOT_RUN":
                groups[path]=data
                jobs.append((path,r))
    changes=Counter()
    regressions=[]
    with ThreadPoolExecutor(args.workers) as pool:
        for (path,row), new in zip(jobs,pool.map(lambda pair: replay(pair[1],args.scratch),jobs)):
            if row["expected_match"] and not new["expected_match"]:
                regressions.append((path.parent.parent.name,row["case"],row["strategy"],row["effective_status"],new["effective_status"]))
            changes[row["effective_status"],new["effective_status"]]+=1
            row.update(new)
    print("Auto transitions",dict(changes),"regressions",regressions,flush=True)
    if regressions:
        return 1
    for p,data in groups.items():
        data["auto_implementation_sha256"]=impl
        save(p,data)
    return 0


if __name__=="__main__":
    raise SystemExit(main())
