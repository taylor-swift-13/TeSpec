"""Rerun field-layout jobs and all previously matching Auto cases from a frozen baseline."""

import argparse
from collections import Counter, defaultdict
from concurrent.futures import as_completed
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

sys.path.insert(0, str(ROOT))
from spectest.layout_job import auto_layout_modules
from spectest.routes import measure


def run_batch(work):
    folder, group, items = work
    folder.mkdir(parents=True, exist_ok=True)
    receipt = folder / "result.json"
    if receipt.exists():
        return read(receipt)
    job, _, _, _ = make_test_job(items[0][0], folder)
    template = read(job)
    modules = auto_layout_modules(job)
    items = [(t, r) for t, r in items if modules or r["expected_match"]]
    if not items:
        return None
    mapping = {}
    for task, row in items:
        case = row["executor_case_id"]
        if case in mapping:
            raise ValueError("Duplicate execution ID")
        mapping[case] = dict(task[1][0][2], id=case)
    template["binds"] = list(mapping.values())
    save(job, template)
    result = {
        "group": group,
        "variant": items[0][1]["variant"],
        "strategy": items[0][1]["strategy"],
        "function": template["function"],
        "layout": None,
        "rows": [],
        "regressions": [],
    }
    if modules:
        dest = folder / "layout"
        prep_receipt = folder / "preparation/receipt.json"
        if prep_receipt.is_file():
            cost = read(prep_receipt)
        else:
            cost = measure(
                [
                    sys.executable,
                    "-B",
                    "-m",
                    "spectest.routes",
                    "--prepare-auto-layout",
                    str(job),
                    str(dest),
                ],
                folder / "preparation",
            )
            save(prep_receipt, cost)
        if cost["exit_code"]:
            raise RuntimeError(str(folder) + ": " + (folder / "preparation/stderr.log").read_text()[-900:])
        receipt_data = read(folder / "preparation/stdout.log")
        if receipt_data["status"] != "bound" or receipt_data["original_job_sha256"] != fingerprint(job):
            raise ValueError("Unverified layout job")
        template = read(Path(receipt_data["job"]))
        result["layout"] = {
            "sha256": receipt_data["layout_sha256"],
            "modules": receipt_data["modules"],
            "libraries": receipt_data["libraries"],
            "cost": cost | {"tokens": 0, "model_calls": 0},
        }
    batches = [[i] for i in items] if modules else [items]
    summary = Counter()
    for index, batch in enumerate(batches):
        out = folder / ("run-" + str(index))
        active = folder / ("input-" + str(index) + ".json")
        save(active, template | {"binds": [mapping[r["executor_case_id"]] for _, r in batch]})
        command = [
            sys.executable,
            "-B",
            "-m",
            "spectest",
            "routes",
            str(active),
            "--route",
            "auto",
            "--output-dir",
            str(out),
        ]
        if not (out / "routes.json").is_file():
            proc = subprocess.run(command, cwd=ROOT, capture_output=True, text=True)
            if proc.returncode:
                raise RuntimeError(str(folder) + ": " + proc.stderr[-600:])
        routes = read(out / "routes.json")
        native = read(out / "native/report.json")
        if native["provenance"]["source_sha256"] != fingerprint(Path(template["source"])):
            raise ValueError("Wrong source")
        decisions = (
            {r["id"]: r for r in read(out / "auto/report.json")["results"]}
            if (out / "auto/report.json").exists()
            else {}
        )
        if len(routes["cases"]) != len(batch) or len(native["results"]) != len(batch):
            raise ValueError("Incomplete batch")
        if not modules and routes["auto_layout"]["status"] != "not_required":
            raise ValueError("Unexpected change in layout discovery")
        for (_, old), c, r in zip(batch, native["results"], routes["cases"]):
            if old["executor_case_id"] != c["id"] or c["id"] != r["case_id"]:
                raise ValueError("Wrong input")
            final = decisions.get(c["id"], c)
            status = final["status"]
            match = status == old["expected"] and (
                status != "CRASH" or matches_crash(final, old["expected_fault_code"])
            )
            goal = c.get("vc", {}).get("immutable_sha256", {}).get("goal")
            if old["expected_match"]:
                summary["previously_matching"] += 1
                if not match:
                    result["regressions"].append(
                        [old["case"], old["effective_status"], status, final["reason"]]
                    )
            if modules:
                target = (
                    old["auto_status"] == "UNKNOWN"
                    and (old.get("auto_diagnostic") or {}).get("entry")
                    == "unbound_computational_field_notation"
                )
                entry = (final.get("auto_route") or {}).get("entry") or {}
                costs = routes["routes"].get("auto")
                generated = c.get("generated_source")
                actual = fingerprint(Path(generated)) if generated and c.get("command") else None
                if actual and (
                    c.get("generated_source_sha256", actual) != actual
                    or f"--input-file={generated}" not in c["command"]
                ):
                    raise ValueError("Executed source hash mismatch")
                result["rows"].append(
                    {
                        "case": old["case"],
                        "target": target,
                        "expected": old["expected"],
                        "match": match,
                        "input_sha256": old["input_sha256"],
                        "source_sha256": old["source_sha256"],
                        "executed_source_sha256": actual,
                        "old_goal_sha256": old["goal_sha256"],
                        "new_goal_sha256": goal,
                        "old_native_report_sha256": old["native_report_sha256"],
                        "native_report_sha256": routes["native_report_sha256"],
                        "old_status": old["effective_status"],
                        "native_status": c["status"],
                        "entry": final.get("precondition_result"),
                        "entry_reason": entry.get("reason"),
                        "auto": r["auto_status"],
                        "status": status,
                        "reason": final.get("reason"),
                        "vc_diagnostics": sorted(
                            {
                                (v["status"], v["reason"])
                                for v in (final.get("auto_route") or {}).get("results", [])
                            }
                        )
                        if not match
                        else [],
                        "branch_counts": branch_counts(c),
                        "native_cost": routes["native_cost"],
                        "layout_check_cost": {
                            k: routes["auto_layout"][k]
                            for k in ("wall_seconds", "max_process_rss_kib", "tokens", "model_calls")
                        },
                        "auto_cost": {
                            k: costs[k]
                            for k in ("wall_seconds", "max_process_rss_kib", "tokens", "model_calls")
                        }
                        if costs
                        else None,
                    }
                )
    result["regression"] = dict(summary)
    save(receipt, result)
    return result


def publish(scratch):
    from organize_tespec_routes import reference
    from publish_current_tables import publish as publish_table

    index_path = RESULTS / "group-result-cost-index.json"
    index = read(index_path)
    groups = {}
    total = Counter()
    outcomes = Counter()
    issues = {}
    for entry in index["groups"]:
        group = entry["program_group"]
        base = RESULTS / group / "tespec"
        baseline = read(base / "current-executions.json")["executions"]
        old = {(r["variant"], r["case"], r["strategy"]): r for r in baseline}
        seen = {}
        prior_matches = 0
        cohorts = []
        for file in sorted((scratch / group).glob("*/result.json")):
            data = read(file)
            if data["regressions"]:
                raise ValueError(f"Previous match lost in {file}: {data['regressions']}")
            prior_matches += data["regression"].get("previously_matching", 0)
            if not data["layout"]:
                continue
            for r in data["rows"]:
                key = data["variant"], r["case"], data["strategy"]
                orig = old[key]
                if key in seen or (r["expected"], r["input_sha256"], r["old_native_report_sha256"]) != (
                    orig["expected"],
                    orig["input_sha256"],
                    orig["native_report_sha256"],
                ):
                    raise ValueError(f"Invalid baseline linkage: {key}")
                if r["target"] and (
                    not r["new_goal_sha256"] or r["new_goal_sha256"] == r["old_goal_sha256"]
                ):
                    raise ValueError(f"Missing new entry VC: {key}")
                seen[key] = r
            cohorts.append({k: data[k] for k in ("function", "variant", "strategy", "layout", "rows")})
        targets = {
            k
            for k, r in old.items()
            if r["auto_status"] == "UNKNOWN"
            and (r.get("auto_diagnostic") or {}).get("entry") == "unbound_computational_field_notation"
        }
        if targets != {k for k, r in seen.items() if r["target"]} or prior_matches != sum(
            r["expected_match"] for r in baseline
        ):
            raise ValueError(f"Incomplete regression in {group}")
        statuses = Counter(
            seen[k]["status"] if k in seen else r["effective_status"] for k, r in old.items()
        )
        matches = sum(seen[k]["match"] if k in seen else r["expected_match"] for k, r in old.items())
        counts = dict(
            executions=len(old),
            previously_matching_retested=prior_matches,
            matches=matches,
            rebound=len(seen),
            target=len(targets),
            target_entry_sat=sum(seen[k]["entry"] == "SAT" for k in targets),
            target_expected_matches=sum(seen[k]["match"] for k in targets),
        )
        groups[group] = counts | {"statuses": dict(statuses)}
        total.update(counts)
        outcomes.update(statuses)
        if cohorts:
            dest = base / "auto-layout.json"
            save(
                dest,
                {
                    "schema": "tespec-auto-layout/v1",
                    "original_profile": reference(base / "current-executions.json"),
                    "group": group,
                    "summary": groups[group],
                    "batches": cohorts,
                },
            )
            groups[group]["evidence"] = reference(dest)
            unknowns = [
                {
                    "variant": k[0],
                    "case": k[1],
                    "strategy": k[2],
                    "entry": seen[k]["entry"],
                    "status": seen[k]["status"],
                    "vc_diagnostics": seen[k]["vc_diagnostics"],
                }
                for k in sorted(targets)
                if not seen[k]["match"]
            ]
            if unknowns:
                issues[group] = {"source": reference(dest), "executions": unknowns}
            publish_table(group)
    summary = {
        "schema": "tespec-auto-layout-overview/v1",
        **total,
        "statuses": dict(outcomes),
        "baseline_profile": "current_route_measurement",
        "groups": groups,
        "target_mismatches": "benchmark/results/tespec-unexpected/auto-layout.json",
    }
    save(
        RESULTS / "tespec-unexpected/auto-layout.json",
        {"schema": "tespec-layout-unexpected/v1", "groups": issues},
    )
    index["default_auto_measurement"] = summary
    import json

    index_path.write_text(json.dumps(index, indent=2, ensure_ascii=False) + "\n")
    print(dict(total), dict(outcomes))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", required=True, type=Path)
    parser.add_argument("--workers", type=int, default=4)
    parser.add_argument("--group", action="append")
    parser.add_argument(
        "--publish-only",
        action="store_true",
        help="Audit collected batches and rebuild the Auto cost tables.",
    )
    args = parser.parse_args()
    if args.publish_only:
        return publish(args.scratch)
    jobs = []
    for path in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        group = path.parts[-3]
        if args.group and group not in args.group:
            continue
        tasks, _, _ = inputs(group)
        buckets = defaultdict(list)
        for r in read(path)["executions"]:
            k = r["variant"], r["case"], r["strategy"]
            job = tasks[k]
            (function, source, _, _), bits, _ = job
            buckets[(k[0], k[2], function, source["path"], bits)].append(((k, job), r))
        for i, items in enumerate(buckets.values()):
            jobs.append((args.scratch / group / str(i), group, items))
    # Start with families known to contain unresolved entries.
    jobs.sort(
        key=lambda j: not any(
            (r.get("auto_diagnostic") or {}).get("entry") == "unbound_computational_field_notation"
            for _, r in j[2]
        )
    )
    failed = []
    with ThreadPoolExecutor(args.workers) as pool:
        futures = {pool.submit(run_batch, j): j[0] for j in jobs}
        for f in as_completed(futures):
            try:
                data = f.result()
                if data and (data["rows"] or data["regressions"]):
                    print(futures[f], len(data["rows"]), data["regressions"], flush=True)
            except Exception as exc:
                failed.append(str(futures[f]))
                print("ERROR", futures[f], str(exc), flush=True)
    if failed:
        raise SystemExit(f"{len(failed)} incomplete batches")


if __name__ == "__main__":
    main()
