#!/usr/bin/env python3
"""Measure the current native/Auto matrix and retain frozen reports for residual ITP."""
import argparse
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
from tempfile import mkdtemp
import shutil

from organize_tespec_routes import BINARY, ROOT, RESULTS, digest, fingerprint, inputs, read, run_one, save


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--group", action="append")
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=2)
    args = parser.parse_args()
    groups = args.group or sorted(p.name for p in (ROOT / "benchmark/programs").iterdir() if p.is_dir())
    args.scratch.mkdir(parents=True, exist_ok=True)
    sources = sorted((ROOT / "spectest").glob("*.py")) + [Path(__file__), Path(__file__).with_name("organize_tespec_routes.py")]
    implementation = digest({str(p.relative_to(ROOT)): fingerprint(p) for p in sources})
    for group in groups:
        tasks, _, _ = inputs(group)
        plan = ROOT / "benchmark/programs" / group / "evaluation-plan.json"
        identity = {"binary_sha256": fingerprint(BINARY), "plan_sha256": fingerprint(plan),
                    "implementation_sha256": implementation, "workers": args.workers}
        output = RESULTS / group / "tespec/current-executions.json"
        if output.exists() and read(output)["profile"] == identity:
            old = read(output)["executions"]
            if {(r["variant"], r["case"], r["strategy"]) for r in old} == tasks.keys() and len(old) == len(tasks):
                continue
        def run(item):
            key, ((function, source, bind, expected), _, fault) = item
            # Keep native reports outside the repository while their ITP task is outstanding.
            folder = Path(mkdtemp(dir=args.scratch))
            measured = run_one(item, workspace=folder)
            if measured["auto_status"] != "NOT_RUN":
                link = args.scratch / measured["native_report_sha256"]
                link.symlink_to(folder, target_is_directory=True)
            else:
                shutil.rmtree(folder)
            return {"variant": key[0], "case": key[1], "strategy": key[2],
                    "source_sha256": source["sha256"], "input_sha256": digest(bind),
                    "expected": expected, "expected_fault_code": fault,
                    **{k: source[k] for k in ("original_source_sha256",) if k in source},
                    **({"qcp_input_fixture_path": source["path"]} if "original_source_sha256" in source else {}),
                    **measured}
        with ThreadPoolExecutor(args.workers) as pool:
            rows = list(pool.map(run, tasks.items()))
        save(output, {"schema": "tespec-measured-executions/v1", "group": group, "profile": identity,
                      "executions": rows})
        print(group, len(rows), sum(r.get("branch_evaluation") is not None for r in rows), flush=True)


if __name__ == "__main__":
    main()
