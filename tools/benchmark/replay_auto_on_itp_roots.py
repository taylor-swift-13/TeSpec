#!/usr/bin/env python3
"""Measure the current Auto route on exactly the frozen native reports used by ITP."""
import argparse
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import subprocess

from current_test_plan import executed_source
from organize_tespec_routes import (
    ROOT, RESULTS, branch_counts, digest, fingerprint, inputs, read, reference, save,
)
from regress_current_auto import replay
from replay_guarded_auto import implementation_hash


def provenance():
    head = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip()
    paths = subprocess.check_output([
        "git", "ls-files", "--modified", "--others", "--exclude-standard", "-z",
        "--", "spectest", "tools/finite_spatial_smt",
    ], cwd=ROOT).decode().split("\0")
    changed = {p: fingerprint(ROOT / p) if (ROOT / p).is_file() else None
               for p in sorted(set(paths)) if p.endswith(".py") and not Path(p).name.startswith("test_")}
    return {"git_head": head, "implementation_sha256": implementation_hash(),
            "worktree_python_changes": changed, "runner": reference(Path(__file__).resolve())}


def validate(row, detail, directory, binary_sha):
    native = directory / "out/native/report.json"
    if fingerprint(native) != row["native_report_sha256"]:
        raise ValueError(f"native hash differs in {directory}")
    report = read(native)
    case, = report["results"]
    (function, source, bind, expected), _, fault = detail
    if (source["sha256"], digest(bind), expected, fault) != (
            row["source_sha256"], row["input_sha256"], row["expected"], row["expected_fault_code"]):
        raise ValueError(f"changed plan input or oracle in {directory}")
    prov = report["provenance"]
    if (fingerprint(Path(report["source"])), fingerprint(Path(report["job"])), binary_sha) != (
            prov["source_sha256"], prov["job_sha256"], prov["binary_sha256"]):
        raise ValueError(f"job or source differs in {directory}")
    if prov["source_sha256"] != source["sha256"]:
        strategy = row.get("relocated_strategy")
        if not strategy or reference(ROOT / strategy["path"]) != strategy:
            raise ValueError(f"missing relocation provenance in {directory}")
    if (case["arguments"], case["bindings"], case["id"], case["execution_strategy"], report["function"]) != (
            bind.get("args", {}), bind.get("values", {}), row["executor_case_id"], row["strategy"], function):
        raise ValueError(f"different execution in {directory}")
    if (executed_source(report, prov["source_sha256"]), case["status"], branch_counts(case)) != (
            row["executed_source_sha256"], row["native_status"], row["branch_evaluation"]):
        raise ValueError(f"different native result in {directory}")
    vc = case["vc"]
    if vc["immutable_sha256"]["goal"] != row["goal_sha256"]:
        raise ValueError(f"changed original obligations in {directory}")
    for key, expected_hash in vc["immutable_sha256"].items():
        if fingerprint(Path(vc["files"][key])) != expected_hash:
            raise ValueError(f"changed original {key} in {directory}")
    for key in ("coq_dependencies", "generated_coq_dependencies", "runtime_dependencies"):
        for dependency in vc.get(key, []):
            if dependency.get("source") and fingerprint(Path(dependency["source"])) != dependency["sha256"]:
                raise ValueError(f"changed VC dependency in {directory}")
    return case


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True, help="Original hash-addressed native reports")
    parser.add_argument("--workers", type=int, default=2)
    args = parser.parse_args()
    pinned = provenance()
    pending = {}
    baselines = {}
    seen = set()
    for current in sorted(RESULTS.glob("*/tespec/current-executions.json")):
        group = current.parents[1].name
        data = read(current)
        baselines[group] = reference(current)
        tasks, _, _ = inputs(group)
        work = []
        for row in data["executions"]:
            if row["auto_status"] == "NOT_RUN":
                continue
            key = row["variant"], row["case"], row["strategy"]
            native_hash = row["native_report_sha256"]
            if native_hash in seen:
                raise ValueError(f"duplicate native report {native_hash}")
            seen.add(native_hash)
            directory = args.scratch / native_hash
            validate(row, tasks[key], directory, data["profile"]["binary_sha256"])
            work.append(row)
        pending[group] = work

    publications = {}
    with ThreadPoolExecutor(args.workers) as pool:
        for group, rows in pending.items():
            records = {}
            for row, result in zip(rows, pool.map(lambda r: replay(r, args.scratch), rows)):
                record = {field: row[field] for field in (
                    "variant", "case", "strategy", "executor_case_id", "source_sha256",
                    "executed_source_sha256", "input_sha256", "goal_sha256",
                    "native_status", "expected", "expected_fault_code", "branch_evaluation",
                )}
                cost = result["auto"]
                if (cost["status"] != "COMPLETED" or cost["wall_seconds"] <= 0
                        or cost["max_process_rss_kib"] <= 0 or cost["tokens"] or cost["model_calls"]):
                    raise ValueError(f"invalid Auto measurement for {row['native_report_sha256']}")
                record.update(effective_status=result["effective_status"], expected_match=result["expected_match"],
                              reason=result["reason"], auto=cost)
                records[row["native_report_sha256"]] = record
            publications[group] = {"schema": "auto-on-itp-roots/v1", "group": group, "provenance": pinned,
                                   "baseline": baselines[group], "executions": records}
    if provenance() != pinned:
        raise ValueError("implementation or Git revision changed during measurement")
    for group, value in publications.items():
        base = RESULTS / group / "tespec"
        if reference(base / "current-executions.json") != baselines[group]:
            raise ValueError(f"changed baseline for {group}")
        save(base / "auto-on-itp-roots.json", value)
    print("Measured", len(seen), Counter(r["effective_status"] for v in publications.values()
                                         for r in v["executions"].values()), flush=True)


if __name__ == "__main__":
    main()
