"""Measure the guards-enabled Auto profile against the previous layout-bound results."""

import argparse
import json
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import subprocess
import sys

from organize_tespec_routes import (
    ROOT,
    RESULTS,
    inputs,
    read,
    save,
    fingerprint,
    make_test_job,
    branch_counts,
)
from current_test_plan import matches_crash


def batches(out):
    work = []
    for path in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        group = path.parts[-3]
        tasks, _, _ = inputs(group)
        profile = path.with_name("auto-layout.json")
        overlays = {}
        if profile.is_file():
            for b in read(profile)["batches"]:
                for r in b["rows"]:
                    overlays[b["variant"], r["case"], b["strategy"]] = r
        buckets = defaultdict(list)
        for row in read(path)["executions"]:
            key = row["variant"], row["case"], row["strategy"]
            recent = overlays.get(key, {})
            target = recent.get("target") and recent["status"] == "UNKNOWN"
            if not (target or recent.get("match", row["expected_match"])):
                continue
            detail = tasks[key]
            (function, source, _, _), bits, _ = detail
            mode = "target" if target else "regression"
            bucket = (
                mode,
                key[0],
                key[2],
                function,
                source["path"],
                bits,
                key[1] if target else None,
            )
            buckets[bucket].append(((key, detail), row, recent))
        for n, (key, items) in enumerate(buckets.items()):
            work.append((out / group / str(n), group, key[0], items))
    return sorted(work, key=lambda job: job[2] != "target")


def run(job):
    directory, group, mode, items = job
    directory.mkdir(parents=True, exist_ok=True)
    dest = directory / "measurement.json"
    if dest.is_file():
        return read(dest)
    input_job, _, src, _ = make_test_job(items[0][0], directory)
    data = read(input_job)
    data["binds"] = [
        dict(task[1][0][2], id=old["executor_case_id"]) for task, old, _ in items
    ]
    save(input_job, data)
    out = directory / "out"
    cmd = [
        sys.executable,
        "-B",
        "-m",
        "spectest",
        "routes",
        str(input_job),
        "--route",
        "auto",
        "--output-dir",
        str(out),
    ]
    proc = subprocess.run(cmd, capture_output=True, text=True, cwd=ROOT)
    if proc.returncode:
        raise RuntimeError(f"{input_job}: {proc.stderr[-800:]}")
    routes = read(out / "routes.json")
    native = read(out / "native/report.json")
    final = (
        read(out / "auto/report.json")
        if (out / "auto/report.json").exists()
        else native
    )
    by_id = {c["id"]: c for c in final["results"]}
    if len(by_id) != len(items) or routes["native_report_sha256"] != fingerprint(
        out / "native/report.json"
    ):
        raise ValueError("incomplete execution identities")
    bad, rows = [], []
    for task, r, prev in items:
        key, detail = task
        c = by_id[r["executor_case_id"]]
        if c["arguments"] != detail[0][2].get("args", {}) or c["bindings"] != detail[0][
            2
        ].get("values", {}):
            raise ValueError(f"{input_job}: binding mismatch")
        match = c["status"] == r["expected"] and (
            c["status"] != "CRASH" or matches_crash(c, r["expected_fault_code"])
        )
        if not match and mode == "regression":
            bad.append([*key, r["expected"], c["status"], c["reason"]])
        if mode == "target":
            layout = routes["auto_layout"]
            if layout["original_job_sha256"] != fingerprint(input_job) or layout[
                "original_source_sha256"
            ] != fingerprint(src):
                raise ValueError("stale prepared layout")
            metrics = ("wall_seconds", "max_process_rss_kib", "tokens")
            gd = read(Path(layout["job"]))["field_layout_context"].get(
                "guard_projection", {}
            )
            vc = c.get("vc", {})
            rows.append(
                dict(
                    variant=key[0],
                    case=key[1],
                    strategy=key[2],
                    function=data["function"],
                    expected=r["expected"],
                    status=c["status"],
                    match=match,
                    entry=c["precondition_result"],
                    phases=c["phases"],
                    reason=c["reason"],
                    old_goal=prev["new_goal_sha256"],
                    goal=vc.get("immutable_sha256", {}).get("goal"),
                    input_sha256=r["input_sha256"],
                    source_sha256=fingerprint(src),
                    executed_sha256=c.get("generated_source_sha256"),
                    native_sha256=routes["native_report_sha256"],
                    branch_counts=branch_counts(c),
                    projection_sha256=gd.get("sha256"),
                    layout_sha256=layout.get("layout_sha256"),
                    recheck=c.get("auto_guard_recheck"),
                    layout_cost={k: layout[k] for k in metrics},
                    native_cost=routes["native_cost"],
                    auto_cost={k: routes["routes"]["auto"][k] for k in metrics}
                    if "auto" in routes["routes"]
                    else None,
                    diagnostics=[
                        (s["status"], s["reason"])
                        for s in c.get("auto_route", {}).get("results", [])
                    ],
                )
            )
    result = dict(group=group, mode=mode, executions=len(items), bad=bad, rows=rows)
    save(dest, result)
    return result


def timeout_target(batch):
    return batch["mode"] == "target" and any(
        row["status"] == "UNKNOWN"
        and any("timeout" in reason for _, reason in row["diagnostics"])
        for row in batch["rows"]
    )


def retry_timeouts(scratch):
    # Repeat once, serially, at the same solver limit. Preserve both observations.
    for directory, group, mode, items in batches(scratch):
        if mode == "target" and timeout_target(read(directory / "measurement.json")):
            run((directory / "timeout-retry", group, mode, items))


def publish_run(scratch, prior_scratch):
    from organize_tespec_routes import BINARY, digest, reference
    from spectest.auto_guard_recheck import (
        alignment_proof_source,
        checked,
        digest as byte_digest,
    )
    from publish_current_tables import publish

    targets = defaultdict(list)
    regressions = defaultdict(list)
    costs = defaultdict(lambda: defaultdict(list))
    mismatches = []
    regression_branches = defaultdict(Counter)
    verified_proofs = Counter()
    for directory, group, mode, items in batches(scratch):
        batch = read(directory / "measurement.json")
        first_attempt = None
        retry = directory / "timeout-retry"
        if (retry / "measurement.json").is_file():
            if not timeout_target(batch):
                raise ValueError("unexpected retry for an execution without a timeout")
            (first_attempt,) = batch["rows"]
            directory = retry
            batch = read(directory / "measurement.json")
        routes = read(directory / "out/routes.json")
        native = directory / "out/native/report.json"
        if (
            fingerprint(native) != routes["native_report_sha256"]
            or routes["requested_route"] != "auto"
        ):
            raise ValueError(f"{directory}: unexpected native evidence")
        report = directory / "out/auto/report.json" if routes["routes"] else native
        cases = {case["id"]: case for case in read(report)["results"]}
        if set(cases) != {r["executor_case_id"] for _, r, _ in items} or len(
            items
        ) != len(cases):
            raise ValueError(f"{directory}: wrong execution inventory")
        identities = []
        for (key, detail), row, previous in items:
            case = cases[row["executor_case_id"]]
            source, bind = detail[0][1:3]
            if (
                digest(bind) != row["input_sha256"]
                or fingerprint(ROOT / source["path"]) != source["sha256"]
                or source["sha256"] != row["source_sha256"]
            ):
                raise ValueError(f"{directory}: stale input or source")
            match = case["status"] == row["expected"] and (
                case["status"] != "CRASH"
                or matches_crash(case, row["expected_fault_code"])
            )
            receipt = case.get("auto_guard_recheck")
            if receipt:
                manifest = case["vc"]
                if receipt["goal_sha256"] != manifest["immutable_sha256"]["goal"]:
                    raise ValueError("final guard proof refers to a different VC")
                (dep,) = (
                    dep
                    for dep in manifest["generated_coq_dependencies"]
                    if dep["module"] == "input_def"
                )
                raw = checked(dep["staged"], dep["sha256"])
                versions = receipt["generated"]["input_def"]
                if versions["original"] != byte_digest(raw):
                    raise ValueError("original alignment source hash differs")
                if versions["original"] != versions["compiled_source"]:
                    rebuilt = alignment_proof_source(
                        raw.decode(), manifest["target_layout"]
                    )
                    if byte_digest(rebuilt.encode()) != versions["compiled_source"]:
                        raise ValueError(
                            "final alignment proof differs from the compiled proof"
                        )
                    verified_proofs[mode] += 1
            identities.append(
                [*key, row["input_sha256"], row["expected"], case["status"], match]
            )
            if mode == "regression":
                counters = branch_counts(case)
                if counters is not None:
                    regression_branches[group].update(counters)
                    regression_branches[group]["records"] += 1
                if not match:
                    mismatches.append([group, *identities[-1]])
                continue
            (record,) = batch["rows"]
            if (
                tuple(record[k] for k in ("variant", "case", "strategy")) != key
                or record["match"] != match
                or record["goal"] != case["vc"]["immutable_sha256"]["goal"]
                or record["old_goal"] != previous["new_goal_sha256"]
            ):
                raise ValueError(f"{directory}: wrong target evidence")
            record["native_status"] = read(native)["results"][0]["status"]
            if first_attempt:
                record["initial_attempt"] = {
                    k: first_attempt[k]
                    for k in (
                        "status",
                        "reason",
                        "phases",
                        "entry",
                        "goal",
                        "projection_sha256",
                        "native_sha256",
                        "layout_cost",
                        "native_cost",
                        "auto_cost",
                        "recheck",
                        "diagnostics",
                        "branch_counts",
                    )
                }

            record["diagnostics"] = [
                {
                    "vc_index": vc["vc_index"],
                    "roots": case["vc_results"][vc["vc_index"]]["proof_roots"],
                    "reason": vc["reason"],
                    "artifact_sha256": fingerprint(vc["artifact"]),
                }
                for vc in case.get("auto_route", {}).get("results", [])
                if vc["status"] == "UNKNOWN"
            ]
            for vc in case.get("auto_route", {}).get("results", []):
                if vc["status"] == "VALID":
                    proof = read(Path(vc["artifact"]))
                    if "prior_heap_query" in proof and "heap_witnesses" in proof:
                        record.setdefault("heap_witness_rechecks", []).append(
                            {
                                "roots": case["vc_results"][vc["vc_index"]][
                                    "proof_roots"
                                ],
                                "prior": proof["prior_heap_query"],
                                "solver_result": proof["solver_result"],
                                "witnesses": proof["heap_witnesses"],
                                "query_sha256": proof.get("query_sha256"),
                                "artifact_sha256": fingerprint(vc["artifact"]),
                            }
                        )
            targets[group].append(record)
        if mode == "regression":
            regressions[group].append(
                {
                    "cases": digest(identities),
                    "native": fingerprint(native),
                    "report": fingerprint(report),
                    "count": len(items),
                }
            )
            for stage, receipt in (
                ("layout", routes["auto_layout"]),
                ("native", routes["native_cost"]),
                ("auto", routes["routes"].get("auto")),
            ):
                if receipt is not None:
                    costs[group][stage].append(receipt)
    groups = {}
    unexpected = []
    for group, rows in targets.items():
        base = RESULTS / group / "tespec"
        path = base / "auto-guards.json"
        rows.sort(key=lambda r: (r["variant"], r["case"], r["strategy"]))
        save(
            path,
            {
                "schema": "tespec-auto-guards/v1",
                "baseline": reference(base / "auto-layout.json"),
                "statuses": dict(Counter(r["status"] for r in rows)),
                "executions": rows,
            },
        )
        publish(group)
        groups[group] = reference(path)
        unexpected.extend(
            {
                "group": group,
                "row": i,
                "case": r["case"],
                "strategy": r["strategy"],
                "expected": r["expected"],
                "native": r["native_status"],
                "auto": r["status"],
                "diagnostics": r["diagnostics"],
            }
            for i, r in enumerate(rows)
            if not r["match"]
        )
    replays = {}
    for group, runs in regressions.items():
        replays[group] = {
            "executions": sum(r["count"] for r in runs),
            "batches": len(runs),
            "receipts_sha256": digest(runs),
            "branch_counts": dict(regression_branches[group]),
            "stages": {
                stage: {
                    "batches": len(ms),
                    "wall_seconds": sum(m["wall_seconds"] for m in ms),
                    "max_process_rss_kib": max(m["max_process_rss_kib"] for m in ms),
                    "tokens": sum(m["tokens"] for m in ms),
                }
                for stage, ms in costs[group].items()
            },
        }
    exceptions = RESULTS / "tespec-unexpected/auto-guards.json"
    save(
        exceptions,
        {
            "schema": "tespec-auto-guards-unexpected/v1",
            "results": groups,
            "executions": unexpected,
            "regressions": mismatches,
            "reproduce": "python3 tools/benchmark/regress_auto_guards.py --mode target --scratch NEW_DIR",
        },
    )
    index_file = RESULTS / "group-result-cost-index.json"
    index = read(index_file)
    all_rows = [r for rows in targets.values() for r in rows]
    index["auto_guard_measurement"] = {
        "schema": "tespec-auto-guards/v1",
        "target": len(all_rows),
        "binary_sha256": fingerprint(BINARY),
        "alignment_generator_sha256": fingerprint(
            ROOT / "spectest/auto_guard_recheck.py"
        ),
        "reproduced_alignment_proofs": dict(verified_proofs),
        "model_calls": 0,
        "tokens": 0,
        "initial_target_statuses": dict(
            Counter(r.get("initial_attempt", r)["status"] for r in all_rows)
        ),
        "target_statuses": dict(Counter(r["status"] for r in all_rows)),
        "final_context_rechecks": sum(r["recheck"] is not None for r in all_rows),
        "previously_matching_retested": sum(r["executions"] for r in replays.values()),
        "regression_mismatches": len(mismatches),
        "target_evidence": groups,
        "unexpected": reference(exceptions),
        "regression_groups": replays,
    }
    trials = []
    for prior in prior_scratch:
        stages = defaultdict(list)
        counts = Counter()
        for directory, _, mode, _ in batches(prior):
            counts[mode] += read(directory / "measurement.json")["executions"]
            routes = read(directory / "out/routes.json")
            for stage, receipt in (
                ("layout", routes["auto_layout"]),
                ("native", routes["native_cost"]),
                ("auto", routes["routes"].get("auto")),
            ):
                if receipt is not None:
                    stages[stage].append(receipt)
        trials.append(
            {
                "executions": dict(counts),
                "stages": {
                    k: {
                        "wall_seconds": sum(m["wall_seconds"] for m in ms),
                        "max_process_rss_kib": max(
                            m["max_process_rss_kib"] for m in ms
                        ),
                        "tokens": sum(m["tokens"] for m in ms),
                    }
                    for k, ms in stages.items()
                },
            }
        )
    index["auto_guard_measurement"]["prior_development_runs"] = trials
    index_file.write_text(json.dumps(index, ensure_ascii=False, indent=2) + "\n")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", required=True, type=Path)
    parser.add_argument("--workers", default=4, type=int)
    parser.add_argument("--mode", choices=["target", "regression"])
    parser.add_argument(
        "--publish",
        action="store_true",
        help="Audit and publish a completed run from the scratch directory",
    )
    parser.add_argument(
        "--prior-scratch",
        action="append",
        default=[],
        type=Path,
        help="Include earlier development run costs",
    )
    parser.add_argument(
        "--retry-timeouts",
        action="store_true",
        help="Rerun timed-out target executions once, sequentially, at the same timeout",
    )
    args = parser.parse_args()
    if args.retry_timeouts:
        retry_timeouts(args.scratch)
        return
    if args.publish:
        publish_run(args.scratch, args.prior_scratch)
        return
    jobs = [j for j in batches(args.scratch) if not args.mode or j[2] == args.mode]
    counts = Counter()
    with ThreadPoolExecutor(args.workers) as pool:
        for result in pool.map(run, jobs):
            counts[result["mode"]] += result["executions"]
            if result["bad"]:
                print("REGRESSION", result["bad"], flush=True)
    print(counts, flush=True)


if __name__ == "__main__":
    main()
