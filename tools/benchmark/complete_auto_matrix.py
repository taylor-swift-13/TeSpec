"""Complete the fresh Auto executions outside the hash-audited original-root cohort."""

import argparse
import subprocess
import sys
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from organize_tespec_routes import (
    RESULTS,
    ROOT,
    branch_counts,
    digest,
    fingerprint,
    inputs,
    read,
    reference,
    run_one,
    save,
)
from regress_auto_guards import batches
from replay_guarded_auto import implementation_hash


def inventory(out, *, replay=False):
    index = read(RESULTS / "group-result-cost-index.json")
    prior = index["auto_original_roots_measurement"]
    covered = {
        (group, *key) for _, group, _, items in batches(out) for (key, _), _, _ in items
    }
    if (
        len(covered) != prior["executions"]
        or prior["unexpected"]
        or (not replay and implementation_hash() != prior["implementation_sha256"])
    ):
        raise ValueError(
            "the completed original-root cohort does not match the current implementation"
        )
    jobs = []
    for entry in index["groups"]:
        group = entry["program_group"]
        tasks, _, _ = inputs(group)
        original = read(RESULTS / group / "tespec/current-executions.json")
        for row in original["executions"]:
            key = row["variant"], row["case"], row["strategy"]
            if (group, *key) in covered:
                continue
            detail = tasks[key]
            (_, source, bind, expected), _, fault = detail
            if (digest(bind), source["sha256"], expected, fault) != (
                row["input_sha256"],
                row["source_sha256"],
                row["expected"],
                row["expected_fault_code"],
            ):
                raise ValueError("stale execution identity")
            jobs.append((out / group / digest(key)[:20], group, key, detail, row))
    if len(covered) + len(jobs) != index["current_route_measurement"]["executions"]:
        raise ValueError("incomplete execution matrix")
    return jobs


def measure(job):
    directory, group, key, detail, original = job
    directory.mkdir(parents=True, exist_ok=True)
    dest = directory / "measurement.json"
    if dest.exists():
        return read(dest)
    result = run_one((key, detail), workspace=directory)
    record = {
        k: original[k]
        for k in (
            "variant",
            "case",
            "strategy",
            "expected",
            "expected_fault_code",
            "input_sha256",
            "source_sha256",
        )
    }
    record.update(result)
    cost = record.pop("auto_layout", {})
    record["layout_prepare"] = {
        k: cost.get(k)
        for k in (
            "status",
            "layout_sha256",
            "wall_seconds",
            "max_process_rss_kib",
            "model_calls",
            "tokens",
        )
    }
    record["implementation_sha256"] = implementation_hash()
    if "executor_case_id" in result:
        report = read(directory / "out/native/report.json")
        (native,) = report["results"]
        if (native["arguments"], native["bindings"]) != (
            detail[0][2].get("args", {}),
            detail[0][2].get("values", {}),
        ):
            raise ValueError("binding mismatch")
    save(dest, record)
    return record


def diagnose_timeout(job):
    directory, _, _, _, _ = job
    path = directory / "measurement.json"
    if not path.exists() or read(path).get("reason") != "qcp_timeout":
        return
    out = directory / "timeout-120"
    if (out / "receipt.json").exists():
        return
    out.mkdir(exist_ok=True)
    original = read(directory / "job.json")
    if original["qcp"]["timeout_seconds"] != 30:
        raise ValueError("unexpected primary timeout")
    supplemental = original | {"qcp": original["qcp"] | {"timeout_seconds": 120}}
    for field in ("source", "spec_file"):
        if field in supplemental:
            supplemental[field] = str((directory / supplemental[field]).resolve())
    job_path = out / "job.json"
    save(job_path, supplemental)
    subprocess.run(
        [
            sys.executable,
            "-B",
            "-m",
            "spectest",
            "routes",
            str(job_path),
            "--route",
            "auto",
            "--output-dir",
            str(out / "routes"),
        ],
        cwd=ROOT,
        check=True,
        capture_output=True,
    )
    routes = read(out / "routes/routes.json")
    (case,) = read(out / "routes/native/report.json")["results"]
    if (
        case["id"] != read(path)["executor_case_id"]
        or case["bindings"] != original["binds"][0]["values"]
        or case["arguments"] != original["binds"][0]["args"]
    ):
        raise ValueError("timeout retry input mismatch")
    save(
        out / "receipt.json",
        {
            "budget_seconds": 120,
            "native_report_sha256": routes["native_report_sha256"],
            "native_status": case["status"],
            "native_reason": case["reason"],
            "branch_evaluation": branch_counts(case),
            "layout_cost": {
                k: routes["auto_layout"].get(k)
                for k in ("wall_seconds", "max_process_rss_kib", "tokens")
            },
            "native_cost": routes["native_cost"],
            "auto_cost": {
                k: v
                for k, v in routes["routes"].get("auto", {}).items()
                if k in ("wall_seconds", "max_process_rss_kib", "tokens", "model_calls")
            },
        },
    )


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=3)
    parser.add_argument("--publish", action="store_true")
    parser.add_argument("--diagnose-timeouts", action="store_true")
    args = parser.parse_args()
    jobs = inventory(args.scratch.resolve(), replay=args.publish)
    if args.diagnose_timeouts:
        with ThreadPoolExecutor(args.workers) as pool:
            list(pool.map(diagnose_timeout, jobs))
        return
    if not args.publish:
        with ThreadPoolExecutor(args.workers) as pool:
            print(
                Counter(row["effective_status"] for row in pool.map(measure, jobs)),
                flush=True,
            )
        return
    pinned = read(RESULTS / "group-result-cost-index.json")[
        "auto_original_roots_measurement"
    ]["implementation_sha256"]
    groups = defaultdict(list)
    for directory, group, key, detail, old in jobs:
        r = read(directory / "measurement.json")
        if (
            r["input_sha256"] != old["input_sha256"]
            or r["source_sha256"] != fingerprint(ROOT / detail[0][1]["path"])
            or r["implementation_sha256"] != pinned
            or not r.get("native_report_sha256")
            or r["native_report_sha256"]
            != fingerprint(directory / "out/native/report.json")
        ):
            raise ValueError(f"incomplete execution evidence {directory}")
        extra = directory / "timeout-120/receipt.json"
        if extra.exists():
            r["additional_timeout_diagnostic"] = read(extra)
            (outcome,) = read(extra.parent / "routes/routes.json")["cases"]
            r["additional_timeout_diagnostic"]["effective_status"] = (
                outcome["auto_status"]
                if outcome["eligible"]
                else outcome["native_status"]
            )
        groups[group].append(r)
    refs = {}
    for group, rows in groups.items():
        p = RESULTS / group / "tespec/auto-remaining.json"
        save(
            p,
            {
                "schema": "auto-matrix-remainder/v1",
                "baseline": reference(p.with_name("current-executions.json")),
                "executions": rows,
                "statuses": dict(Counter(r["effective_status"] for r in rows)),
                "matches": sum(r["expected_match"] for r in rows),
            },
        )
        refs[group] = reference(p)
    print(refs)


if __name__ == "__main__":
    main()
