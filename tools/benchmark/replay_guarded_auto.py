"""Replay the Auto backend from the published guarded native VC cohort."""

import argparse
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path
import json
import hashlib
import subprocess
import sys

from current_test_plan import matches_crash
from organize_tespec_routes import (
    ROOT,
    RESULTS,
    branch_counts,
    digest,
    fingerprint,
    read,
    reference,
    save,
)
from regress_auto_guards import batches


def matched(case, expected):
    return case["status"] == expected["expected"] and (
        case["status"] != "CRASH"
        or matches_crash(case, expected["expected_fault_code"])
    )


def inventory(frozen):
    profile = read(RESULTS / "group-result-cost-index.json")["auto_guard_measurement"]
    targets = {}
    for group, ref in profile["target_evidence"].items():
        if reference(ROOT / ref["path"]) != ref:
            raise ValueError("published target evidence hash differs")
        for row in read(ROOT / ref["path"])["executions"]:
            targets[group, row["variant"], row["case"], row["strategy"]] = row
    checks = defaultdict(list)
    jobs = []
    for directory, group, mode, items in batches(frozen):
        retry = directory / "timeout-retry"
        base = retry if (retry / "measurement.json").is_file() else directory
        native = base / "out/native/report.json"
        routes = read(base / "out/routes.json")
        raw_hash = fingerprint(native)
        if routes["native_report_sha256"] != raw_hash:
            raise ValueError(f"changed native report in {base}")
        prior_report = base / "out/auto/report.json" if routes["routes"] else native
        prior = {c["id"]: c for c in read(prior_report)["results"]}
        cases = {}
        identities = []
        for (key, detail), expected, _ in items:
            case_id = expected["executor_case_id"]
            case = prior[case_id]
            match = matched(case, expected)
            source, bind = detail[0][1:3]
            if (
                fingerprint(ROOT / source["path"]) != expected["source_sha256"]
                or digest(bind) != expected["input_sha256"]
            ):
                raise ValueError("input or source changed since measurement")
            old = targets.get((group, *key)) if mode == "target" else None
            if mode == "target" and (
                old is None
                or old["native_sha256"] != raw_hash
                or old["goal"] != case["vc"]["immutable_sha256"]["goal"]
                or old["status"] != case["status"]
                or old["match"] != match
            ):
                raise ValueError("guarded target differs from published evidence")
            if mode == "regression" and not match:
                raise ValueError("guard baseline contains a regression")
            identities.append(
                [
                    *key,
                    expected["input_sha256"],
                    expected["expected"],
                    case["status"],
                    match,
                ]
            )
            cases[case_id] = (key, expected, old if not match else None)
        if cases.keys() != prior.keys() or len(cases) != len(items):
            raise ValueError("case IDs do not match the batch")
        if mode == "regression":
            checks[group].append(
                {
                    "cases": digest(identities),
                    "native": raw_hash,
                    "report": fingerprint(prior_report),
                    "count": len(identities),
                }
            )
        jobs.append(
            (
                group,
                directory.name,
                cases,
                native,
                raw_hash,
                routes["spatial_smt_timeout_ms"],
            )
        )
    if checks.keys() != profile["regression_groups"].keys():
        raise ValueError("incomplete regression groups")
    if any(
        digest(rows) != profile["regression_groups"][g]["receipts_sha256"]
        for g, rows in checks.items()
    ):
        raise ValueError("frozen baseline differs from published receipt set")
    return jobs


def replay(job, out, publish):
    group, batch_id, cases, native, raw_hash, timeout = job
    dest = out / group / batch_id
    if not publish:
        cmd = [
            sys.executable,
            "-B",
            "-m",
            "spectest",
            "routes",
            "--route",
            "auto",
            "--native-report",
            str(native),
            "--output-dir",
            str(dest),
            "--spatial-smt-timeout-ms",
            str(timeout),
        ]
        subprocess.run(cmd, cwd=ROOT, capture_output=True, text=True, check=True)
    routes = read(dest / "routes.json")
    stage = routes["routes"].get("auto")
    if (
        routes["requested_route"] != "auto"
        or routes["native_cost"]["measured_this_run"]
        or routes["spatial_smt_timeout_ms"] != timeout
        or routes["native_report_sha256"] != raw_hash
        or (
            stage
            and (
                stage["status"] != "COMPLETED"
                or stage["tokens"]
                or stage["model_calls"]
            )
        )
    ):
        raise ValueError(f"{dest}: invalid replay")
    final = dest / "auto/report.json" if stage else native
    actual = {c["id"]: c for c in read(final)["results"]}
    if actual.keys() != cases.keys():
        raise ValueError("incomplete replay")
    bad, targets = [], []
    for case_id, (key, expected, old) in cases.items():
        c = actual[case_id]
        ok = matched(c, expected)
        if not ok:
            bad.append([group, *key, expected["expected"], c["status"], c["reason"]])
        if old:
            if (
                len(actual) != 1
                or not stage
                or old["goal"] != c["vc"]["immutable_sha256"]["goal"]
            ):
                raise ValueError(
                    "target comparison requires the same original goal and an individual measurement"
                )
            selected = {x["vc_index"]: x for x in c["auto_route"]["results"]}
            roots = []
            for missing in old["diagnostics"]:
                idx = missing["vc_index"]
                vc = selected[idx]
                evidence = read(Path(vc["artifact"]))
                if c["vc_results"][idx]["proof_roots"] != missing["roots"]:
                    raise ValueError("original VC roots changed")
                roots.append(
                    {
                        "roots": missing["roots"],
                        "previous_reason": missing["reason"],
                        "reason": vc["reason"],
                        "status": vc["status"],
                        "certificate": vc["certificate"],
                        "artifact_sha256": fingerprint(vc["artifact"]),
                    }
                )
                if vc["certificate"] == "KERNEL_CHECKED":
                    terms = evidence["proof_terms"]
                    if (
                        evidence["goal_sha256"] != old["goal"]
                        or terms.keys() != set(missing["roots"])
                        or evidence["proof_roots"] != missing["roots"]
                    ):
                        raise ValueError(
                            "kernel evidence is for a different original root"
                        )
                    roots[-1]["proof_terms"] = {
                        name: {
                            "coq": term,
                            "sha256": hashlib.sha256(term.encode()).hexdigest(),
                        }
                        for name, term in terms.items()
                    }
            targets.append(
                {
                    "variant": key[0],
                    "case": key[1],
                    "strategy": key[2],
                    "expected": expected["expected"],
                    "previous": old["status"],
                    "status": c["status"],
                    "phases": c["phases"],
                    "goal_sha256": old["goal"],
                    "native_sha256": raw_hash,
                    "input_sha256": expected["input_sha256"],
                    "source_sha256": expected["source_sha256"],
                    "executed_sha256": c["generated_source_sha256"],
                    "branch_counts": branch_counts(c),
                    "residual_roots": roots,
                    "auto_cost": {
                        k: stage[k]
                        for k in (
                            "wall_seconds",
                            "max_process_rss_kib",
                            "tokens",
                            "model_calls",
                        )
                    },
                }
            )
    return group, len(cases), routes["eligible_executions"], stage, targets, bad


def implementation_hash():
    files = [
        p
        for directory in (ROOT / "spectest", ROOT / "tools/finite_spatial_smt")
        for p in directory.rglob("*.py")
        if not p.name.startswith("test_")
    ]
    return digest({str(p.relative_to(ROOT)): fingerprint(p) for p in files})


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--frozen", required=True, type=Path)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--workers", default=3, type=int)
    parser.add_argument(
        "--publish",
        action="store_true",
        help="Audit finished replay and update group tables",
    )
    parser.add_argument(
        "--refresh-certificates",
        action="store_true",
        help="Re-run batches whose proof-certificate metadata changed after a writer-only fix",
    )
    args = parser.parse_args()
    marker = args.output / "implementation.json"
    before = implementation_hash()
    refresh = args.output / "certificate-refresh"
    metadata = refresh / "implementation.json"
    jobs = inventory(args.frozen)
    if args.refresh_certificates:
        old = read(args.output / "initial-sources.json")
        now = {str(p.relative_to(ROOT)): fingerprint(p) for p in files}
        if (
            digest(old) != read(marker)["sha256"]
            or now.keys() != old.keys()
            or {f for f in now if now[f] != old[f]}
            != {"spectest/auto_route.py", "spectest/spatial_smt.py"}
            or metadata.exists()
        ):
            raise ValueError(
                "refresh requires a single writer-only change and fresh output"
            )
        changed = []
        for job in jobs:
            group, batch = job[:2]
            report = args.output / group / batch / "auto/report.json"
            if report.is_file() and any(
                v.get("reason") == "original_pure_arm_kernel_checked"
                for case in read(report)["results"]
                for v in case.get("auto_route", {}).get("results", [])
            ):
                replay(job, refresh, False)
                changed.append([group, batch])
        if implementation_hash() != before:
            raise ValueError("implementation changed during certificate refresh")
        save(
            metadata,
            {"initial": read(marker)["sha256"], "sha256": before, "batches": changed},
        )
        return
    if args.publish:
        binding = read(metadata if metadata.is_file() else marker)
        if (
            binding["sha256"] != before
            or binding.get("initial", read(marker)["sha256"]) != read(marker)["sha256"]
        ):
            raise ValueError(
                "cannot publish evidence for a different Auto implementation"
            )
    else:
        if marker.exists():
            raise ValueError("choose an unused replay directory")
        save(marker, {"sha256": before})
        save(
            args.output / "initial-sources.json",
            {str(p.relative_to(ROOT)): fingerprint(p) for p in files},
        )

    refreshed = read(metadata)["batches"] if args.publish and metadata.is_file() else []

    def evaluate(job):
        result = replay(job, args.output, args.publish)
        if list(job[:2]) in refreshed:
            new = replay(job, refresh, True)
            if (
                result[1:3] != new[1:3]
                or result[5] != new[5]
                or len(result[4]) != len(new[4])
            ):
                raise ValueError(
                    "certificate-only refresh changed outcomes or coverage"
                )
            for first, final in zip(result[4], new[4]):
                if (first["status"], first["goal_sha256"]) != (
                    final["status"],
                    final["goal_sha256"],
                ):
                    raise ValueError("different goal or decision after receipt fix")
                final["initial_auto_cost"] = first["auto_cost"]
                final["initial_certificate_tags"] = [
                    r["certificate"] for r in first["residual_roots"]
                ]
            return new
        return result

    result = defaultdict(Counter)
    targets = defaultdict(list)
    bad = []
    with ThreadPoolExecutor(args.workers) as pool:
        for group, n, eligible, stage, selected, unexpected in pool.map(evaluate, jobs):
            result[group].update(
                executions=n,
                auto_executions=eligible,
                targets=len(selected),
                unexpected=len(unexpected),
            )
            if stage:
                result[group].update(
                    auto_wall_seconds=stage["wall_seconds"], auto_batches=1
                )
                result[group]["max_process_rss_kib"] = max(
                    result[group]["max_process_rss_kib"], stage["max_process_rss_kib"]
                )
            for row in selected:
                if "initial_auto_cost" in row:
                    meter = row["initial_auto_cost"]
                    result[group].update(
                        auto_wall_seconds=meter["wall_seconds"], auto_batches=1
                    )
                    result[group]["max_process_rss_kib"] = max(
                        result[group]["max_process_rss_kib"],
                        meter["max_process_rss_kib"],
                    )
            if selected:
                targets[group].extend(selected)
            bad.extend(unexpected)
    if before != implementation_hash():
        raise ValueError("Auto implementation changed during replay")
    counts = {
        k: sum(row[k] for row in result.values())
        for k in ("executions", "targets", "auto_executions", "unexpected")
    }
    print(counts, bad, flush=True)
    if args.publish:
        from publish_current_tables import publish

        refs = {}
        for group, records in targets.items():
            path = RESULTS / group / "tespec/auto-original-roots.json"
            save(
                path,
                {
                    "schema": "auto-original-roots/v1",
                    "previous": reference(path.with_name("auto-guards.json")),
                    "executions": records,
                },
            )
            refs[group] = reference(path)
            publish(group)
        index = RESULTS / "group-result-cost-index.json"
        data = read(index)
        data["auto_original_roots_measurement"] = {
            "schema": "auto-original-roots/v1",
            **counts,
            "groups": result,
            "target_evidence": refs,
            "implementation_sha256": before,
            "initial_implementation_sha256": read(marker)["sha256"],
            "certificate_refresh_batches": refreshed,
            "mismatches": bad,
            "tokens": 0,
            "model_calls": 0,
        }
        index.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


if __name__ == "__main__":
    main()
