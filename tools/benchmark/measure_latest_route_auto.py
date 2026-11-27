"""Measure Auto once per input on the same single-execution native reports as ITP."""

import argparse
from collections import Counter, defaultdict
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

from organize_tespec_routes import (
    RESULTS,
    ROOT,
    digest,
    fingerprint,
    inputs,
    read,
    reference,
    save,
)
from regress_current_auto import replay
from replay_guarded_auto import implementation_hash


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--scratch", type=Path, required=True)
    parser.add_argument("--workers", type=int, default=2)
    parser.add_argument(
        "--diagnose-disagreement",
        action="store_true",
        help="Replay each difference from the batch one more time in sequence at the same budget.",
    )
    parser.add_argument(
        "--diagnostic-timeout-ms",
        type=int,
        help="Record a separate budget sensitivity measurement for every primary UNKNOWN and batch disagreement.",
    )
    args = parser.parse_args()
    if (
        args.diagnostic_timeout_ms is not None
        and not 1 <= args.diagnostic_timeout_ms <= 60000
    ):
        parser.error("diagnostic timeout must be within the solver budget range")
    queue = read(args.scratch / "queue.json")["executions"]
    engine = implementation_hash()
    profile_file = args.scratch / "auto-primary-profile.json"
    if not profile_file.exists():
        save(profile_file, {"implementation_sha256": engine})
    implementation = read(profile_file)["implementation_sha256"]
    records = defaultdict(dict)
    plans = {group: inputs(group)[0] for group in {r["group"] for r in queue}}
    if len(
        set((r["group"], r["variant"], r["case"], r["strategy"]) for r in queue)
    ) != len(queue):
        raise ValueError("Duplicate current execution in ITP inventory")

    def measure(row):
        key = row["variant"], row["case"], row["strategy"]
        native = row["native_report_sha256"]
        root = args.scratch / native
        (case,) = read(root / "out/native/report.json")["results"]
        (func, source, bind, expected), _, fault = plans[row["group"]][key]
        if (source["sha256"], digest(bind), expected, fault) != (
            row["source_sha256"],
            row["input_sha256"],
            row["expected"],
            row["expected_fault_code"],
        ):
            raise ValueError("Source, binding or expectation differs from plan")
        if (
            case["id"],
            case["execution_strategy"],
            case["arguments"],
            case["bindings"],
        ) != (
            row["executor_case_id"],
            row["strategy"],
            bind.get("args", {}),
            bind.get("values", {}),
        ):
            raise ValueError("Native case differs from original input")
        goal = case["vc"]["files"]["goal"]
        if (
            case["vc"]["immutable_sha256"]["goal"] != row["goal_sha256"]
            or fingerprint(Path(goal)) != row["goal_sha256"]
        ):
            raise ValueError("Different original VC")
        timeout = row["spatial_smt_timeout_ms"]
        receipt = root / f"measured-auto-{implementation}-{timeout}.json"
        if receipt.exists():
            rec = read(receipt)
            if any(
                rec[k] != row[k]
                for k in (
                    "batch_native_report_sha256",
                    "native_report_sha256",
                    "input_sha256",
                    "goal_sha256",
                )
            ):
                raise ValueError("Stale current Auto checkpoint")
        else:
            if implementation != engine:
                raise ValueError(
                    "A missing primary measurement requires the original engine or a fresh scratch directory"
                )
            result = replay(row, args.scratch, spatial_smt_timeout_ms=timeout)
            rec = {
                k: row[k]
                for k in (
                    "variant",
                    "case",
                    "strategy",
                    "native_report_sha256",
                    "batch_native_report_sha256",
                    "source_sha256",
                    "executed_source_sha256",
                    "input_sha256",
                    "goal_sha256",
                    "expected",
                    "expected_fault_code",
                    "native_status",
                    "spatial_smt_timeout_ms",
                )
            }
            rec.update(result)
            rec["batch_auto_status"] = row["auto_status"]
            save(receipt, rec)
        for other in sorted(root.glob(f"measured-auto-*-{timeout}.json")):
            if other == receipt:
                continue
            secondary = read(other)
            if any(
                rec[k] != secondary[k]
                for k in (
                    "native_report_sha256",
                    "goal_sha256",
                    "input_sha256",
                    "batch_native_report_sha256",
                )
            ):
                raise ValueError("Secondary measurement uses a different execution")
            profile = other.name.split("-")[2]
            rec.setdefault("additional_profile_runs", {})[profile] = {
                "status": secondary["effective_status"],
                "auto": secondary["auto"],
            }
        diagnostic = root / f"diagnostic-auto-{engine}-{timeout}.json"
        if (
            args.diagnose_disagreement
            and rec["batch_auto_status"] != rec["effective_status"]
            and not diagnostic.exists()
        ):
            save(diagnostic, replay(row, args.scratch, spatial_smt_timeout_ms=timeout))
        primary_diag = root / f"diagnostic-auto-{implementation}-{timeout}.json"
        if primary_diag.exists():
            rec["same_budget_diagnostic"] = read(primary_diag)
        if args.diagnostic_timeout_ms and (
            rec["effective_status"] == "UNKNOWN"
            or rec["batch_auto_status"] != rec["effective_status"]
        ):
            budget = args.diagnostic_timeout_ms
            extended = root / f"budget-auto-{engine}-{budget}.json"
            if not any(root.glob(f"budget-auto-*-{budget}.json")):
                before = implementation_hash()
                diagnostic_result = replay(row, args.scratch, spatial_smt_timeout_ms=budget)
                after = implementation_hash()
                if before != after:
                    save(root / f"changed-profile-{before}-{after}-{budget}.json", diagnostic_result)
                    raise ValueError("Source profile changed during the timed diagnosis")
                save(root / f"budget-auto-{before}-{budget}.json", diagnostic_result)
        for extra in sorted(root.glob("changed-profile-*.json")):
            before, after, budget_arg = extra.stem.split("-")[-3:]
            rec.setdefault("unattributed_profile_diagnostics", []).append({
                "profile_before":before, "profile_after":after, "timeout_ms":int(budget_arg), **read(extra)})
        for extended in sorted(root.glob("budget-auto-*.json")):
            profile, ms = extended.stem.split("-")[-2:]
            rec["additional_budget_diagnostic"] = {
                "timeout_ms": int(ms),
                "implementation_sha256": profile,
                **read(extended),
            }
        return row["group"], native, rec

    with ThreadPoolExecutor(
        1
        if (args.diagnose_disagreement or args.diagnostic_timeout_ms)
        else args.workers
    ) as pool:
        for group, native, rec in pool.map(measure, queue):
            if native in records[group]:
                raise ValueError("Two executions point to the same single-input report")
            records[group][native] = rec
    if implementation_hash() != engine:
        raise ValueError("Auto implementation changed during measurement")
    inventory = {}
    for program in sorted((ROOT / "benchmark/programs").iterdir()):
        if not program.is_dir():
            continue
        group = program.name
        inventory[group] = {
            "residuals": dict(Counter(r["strategy"] for r in records[group].values()))
        }
        if not records[group]:
            continue
        save(
            RESULTS / group / "tespec/latest-auto.json",
            {
                "schema": "latest-single-input-auto/v1",
                "implementation_sha256": implementation,
                "group": group,
                "executions": records[group],
            },
        )
        inventory[group]["auto"] = reference(
            RESULTS / group / "tespec/latest-auto.json"
        )
    save(
        RESULTS / "latest-proof-route-inventory.json",
        {
            "schema": "latest-proof-route-inventory/v1",
            "residuals": len(queue),
            "groups": inventory,
            "scope": "One selected input and every residual obligation from its original native execution.",
        },
    )
    print(
        "Measured",
        len(queue),
        Counter(r["effective_status"] for rs in records.values() for r in rs.values()),
        "changed from batch",
        sum(
            r["batch_auto_status"] != r["effective_status"]
            for rs in records.values()
            for r in rs.values()
        ),
    )


if __name__ == "__main__":
    main()
