"""Finish metered ITP tasks concurrently against frozen reports and checkpoint each result."""
import argparse
from concurrent.futures import ThreadPoolExecutor, wait, FIRST_COMPLETED
import fcntl
from pathlib import Path
import sys

from collect_current_itp import checkpoint
from complete_current_itp import solve
from organize_tespec_routes import RESULTS, read


def already_checked_replay(folder):
    for mask in ("runtime-source-replay-*/routes.json", "legacy-negative-replay-*/routes.json", "peer-positive-replay-*/routes.json"):
        for receipt in folder.glob(mask):
            route = read(receipt)
            if route["native_report_sha256"] != folder.name:
                raise ValueError("Replayed ITP source is attached to a different native execution")
            if route["cases"][0]["itp_status"] in ("PASS", "FAIL", "CRASH"):
                return True
            # No subsequent proof of the positive decision group can close an
            # already refuted original parent. Keep its execution-level UNKNOWN.
            agent = receipt.parent / "itp/agent-report.json"
            if agent.is_file() and any(
                a["check"].get("polarity") == "negative"
                and a["check"].get("proof_status") == "VALID"
                and a["check"].get("vc_status") == "INVALID"
                for a in read(agent)["attempts"]
            ):
                return True
    return False


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", required=True, type=Path)
    parser.add_argument("--task-root", required=True, type=Path)
    parser.add_argument("--windows-python", required=True, type=Path)
    parser.add_argument("--workers", default=2, type=int)
    parser.add_argument("--group", action="append")
    parser.add_argument("--wait-lock", action="store_true",
                        help="Wait for the draining controller of the same cohort before resuming")
    parser.add_argument("--runtime-ready-only", action="store_true",
                        help="Only dispatch tasks whose original runtime imports are already compiled")
    parser.add_argument("--runtime-source-only", action="store_true", help="Only tasks with source-only runtime imports")
    args = parser.parse_args()
    if args.runtime_source_only and args.runtime_ready_only:
        parser.error("Select at most one runtime cohort")
    if args.workers < 1:
        parser.error("workers must be positive")
    if not args.windows_python.is_file():
        parser.error("Windows Python is unavailable")
    # Shared scratch contains both immutable receipts and active model processes.
    # Never dispatch a second controller into the same generation directory.
    cohort_locks = []
    for enabled, name in ((not args.runtime_source_only, "metered-batch.lock"),
                          (not args.runtime_ready_only, "metered-source-only.lock")):
        if enabled:
            lock = (args.scratch / name).open("a")
            fcntl.flock(lock, fcntl.LOCK_EX if args.wait_lock else fcntl.LOCK_EX | fcntl.LOCK_NB)
            cohort_locks.append(lock)
    records = []
    for current in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        if args.group and current.parents[1].name not in args.group:
            continue
        for row in read(current)["executions"]:
            if row["auto_status"] != "NOT_RUN":
                records.append((current, row))

    for repair in (False, True):
        pending = []
        for current, row in records:
            folder = args.scratch / row["native_report_sha256"]
            if args.runtime_ready_only or args.runtime_source_only:
                manifest = read(folder / "out/native/report.json")["results"][0]["vc"]
                has_source_only = any(not dep.get("compiled") for dep in manifest.get("runtime_dependencies", []))
                if has_source_only != args.runtime_source_only:
                    continue
            if already_checked_replay(folder):
                continue
            first = folder / ("generated-itp" if repair else "current-itp") / "routes.json"
            out = folder / ("repair-itp" if repair else "generated-itp")
            if first.is_file() and read(first)["cases"][0]["itp_status"] in ("UNKNOWN", "ERROR") and not out.exists():
                pending.append((current, row))
        print(("repair" if repair else "generate"), "eligible", len(pending), flush=True)
        jobs = iter(pending)
        active = {}
        with ThreadPoolExecutor(args.workers) as pool:
            def dispatch():
                item = next(jobs, None)
                while item is not None and already_checked_replay(args.scratch / item[1]["native_report_sha256"]):
                    item = next(jobs, None)
                if item:
                    current, row = item
                    work = pool.submit(solve, row, args.scratch, args.task_root, args.windows_python, repair)
                    active[work] = item
            for _ in range(args.workers):
                dispatch()
            failures = []
            while active:
                finished, _ = wait(active, return_when=FIRST_COMPLETED)
                for work in finished:
                    current, row = active.pop(work)
                    try:
                        if work.result():
                            checkpoint(args.scratch, current, row)
                    except Exception as error:
                        failures.append(str(error))
                        print("STOP DISPATCH", row["native_report_sha256"], str(error), file=sys.stderr, flush=True)
                    if not failures:
                        dispatch()
            if failures:
                raise SystemExit(1)


if __name__ == "__main__":
    main()
