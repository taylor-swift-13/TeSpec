#!/usr/bin/env python3
"""Run isolated regression workers concurrently; timings are load-dependent.
This is a correctness regression, not a controlled performance comparison.
"""
from concurrent.futures import ThreadPoolExecutor, as_completed
import argparse
import json
from pathlib import Path
import sys
sys.path.insert(0, str(Path(__file__).resolve().parents[2]))
from tools.finite_spatial_smt import regress_completed_groups as shared


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--execution-strategy", choices=("inline", "modular"), default="inline")
    parser.add_argument("--positive-representatives", action="store_true")
    args = parser.parse_args()
    shared.require(1 <= args.workers <= 4, "workers must be 1..4")
    tasks, audit, coverage = shared.load_baseline(None)
    if args.positive_representatives:
        selected = []
        for group in coverage["selected_groups"]:
            candidates = [t for t in tasks if t["group"] == group
                          and all(t["baseline"][m]["status"] == "PASS" for m in ("off", "on"))]
            shared.require(candidates, "no common positive representative: " + group)
            selected.append(candidates[0])
        tasks = selected
        coverage.update(full_complete_group_suite=False, case_pairs=len(tasks),
                        selection="First common baseline PASS input per completed group.")
    coverage["execution_strategy"] = args.execution_strategy
    coverage["worker_concurrency"] = args.workers
    out = shared.output_path(args.output)
    shared.require(not out.exists(), "output must be fresh")
    out.mkdir(parents=True)
    for folder in (shared.ROOT / "spectest", shared.ROOT / "tools/finite_spatial_smt"):
        for path in sorted(folder.rglob("*.py")):
            audit.ref(path)
    for path in (shared.ROOT / "bin/tespec-symexec",
                 shared.ROOT / "bin/tespec-symexec.build.json", Path(__file__)):
        audit.ref(path)
    shared.save(out / "baseline.json", {
        "coverage": coverage, "inputs": tasks, "immutable_sha256": audit.files})
    shared.save(out / "provenance.json", {
        "started_utc": shared.now(), "coverage": coverage,
        "binary_sha256": shared.digest(shared.ROOT / "bin/tespec-symexec"),
        "driver_source_sha256": shared.digest(__file__),
        "worker_source_sha256": shared.digest(shared.__file__),
        "measurement_scope": "Independent worker processes under concurrent load. Time/RSS are observed development-regression costs, not controlled performance comparison.",
        "tokens": 0, "model_calls": 0,
    })
    (out / "driver-source.py").write_bytes(Path(__file__).read_bytes())
    (out / "worker-source.py").write_bytes(Path(shared.__file__).read_bytes())
    (out / "executor-build.json").write_bytes((shared.ROOT / "bin/tespec-symexec.build.json").read_bytes())
    original = shared.cli_arguments
    shared.cli_arguments = lambda task, mode, folder: (
        original(task, mode, folder) + ["--execution-strategy", args.execution_strategy])
    rows = []
    try:
        with ThreadPoolExecutor(max_workers=args.workers) as pool:
            futures = [pool.submit(shared.run_task, task, mode, out, 90)
                       for task in tasks for mode in ("off", "on")]
            for future in as_completed(futures):
                rows.append(future.result())
                if len(rows) % 100 == 0:
                    print("%d/%d executions; %d differences requiring attention" % (
                        len(rows), len(futures), sum(not x["comparison"]["ok"] for x in rows)), flush=True)
    finally:
        shared.cli_arguments = original
    rows.sort(key=lambda x: (x["group"], x["variant"], x["case"], x["mode"]))
    summary = shared.publish_local(out, rows, coverage, audit.verify(),
                                   complete=len(rows) == 2 * len(tasks))
    print(json.dumps(summary))
    return 0 if summary["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
