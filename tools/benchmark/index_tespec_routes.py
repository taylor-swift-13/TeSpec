#!/usr/bin/env python3
"""Index Auto results and historical ITP costs without double-counting receipts."""

from collections import Counter, defaultdict
import csv
import json
from pathlib import Path
import subprocess
import sys
from tempfile import TemporaryDirectory

sys.path.insert(0, str(Path(__file__).resolve().parent))
from organize_tespec_routes import (
    RESULTS,
    ROOT,
    fingerprint,
    inputs,
    read,
    reference,
    save,
)
from replay_dll_add import execute
from spectest.itp_schedule import decision_itp_task
from spectest.proof_reuse import dependency_ids


def checked(ref):
    path = ROOT / ref["path"]
    if fingerprint(path) != ref["sha256"]:
        raise ValueError(f"certificate evidence changed: {path}")
    return read(path)


def bind_dll_add(group, data):
    """Reuse the independently kernel-checked OFF receipt on identical obligations."""
    path = RESULTS / group / "evidence/evaluation.json"
    old = {
        (r["case_id"], r["strategy"]): r
        for r in read(path)["executions"]
        if r["spatial_smt"] == "off" and r.get("certificate")
    }
    tasks, _, _ = inputs(group)
    for row in data["executions"]:
        candidate = old.get((row["case"], row["strategy"]))
        if row["itp_status"] != "UNMEASURED" or not candidate:
            continue
        cert = checked(candidate["certificate"])
        function, source, bind, _ = tasks[row["variant"], row["case"], row["strategy"]][
            0
        ]
        if (
            candidate["source_sha256"] != row["source_sha256"]
            or cert["source"]["sha256"] != row["source_sha256"]
            or row["goal_sha256"] != candidate["vc_sha256"]["goal"]
            or row["goal_sha256"] != cert["goal"]["sha256"]
            or cert["input"] != [bind]
            or not cert["globally_closed"]
            or cert["status"] != "PASS"
        ):
            continue
        context = checked(cert["logical_context"])
        goal = ROOT / cert["goal"]["path"]
        if fingerprint(goal) != row["goal_sha256"]:
            raise ValueError(f"proof goal changed: {goal}")
        with TemporaryDirectory(prefix="tespec-itp-context-") as scratch:
            native_path, _ = execute(
                Path(scratch) / "native",
                function,
                source,
                32,
                bind,
                row["strategy"],
                "off",
            )
            native = read(native_path)["results"][0]
            task = decision_itp_task(native, function)
            if not task or set(task["goals"]) != set(cert["targets"]):
                continue
            manifest = read(Path(task["manifest"]))
            if (
                fingerprint(native["vc"]["files"]["goal"]) != row["goal_sha256"]
                or context["target_layout"] != manifest["target_layout"]
                or any(
                    dependency_ids(context[k]) != dependency_ids(manifest[k])
                    for k in ("coq_dependencies", "runtime_dependencies")
                )
            ):
                continue
        row.update(
            itp_status="PASS",
            itp_certificate=candidate["certificate"],
            itp_cost=cert["metrics"],
            itp_basis="existing_kernel_checked_exact_context",
        )
    save(RESULTS / group / "tespec/routes.json", data)


def historical(folder):
    sources = []
    candidate_paths = [
        "tespec/results.json",
        "tespec/statistics.json",
        "evidence/strategies.json",
        "evidence/attempts.json",
        "evidence/historical-attempts.json",
        "evidence/evaluation.json",
        "evidence/cost-ledger.json",
        "evidence/tespec-native.json",
    ]
    paths = [folder / f for f in candidate_paths]
    paths += sorted(folder.glob("tespec/itp-average*.json"))
    paths += sorted(folder.glob("*itp*/index.json")) + sorted(
        folder.glob("*itp*/receipt.json")
    )
    tracked = set(
        subprocess.check_output(
            ["git", "ls-files", "--", str(folder.relative_to(ROOT))],
            cwd=ROOT,
            text=True,
        ).splitlines()
    )
    for path in paths:
        if path.is_file() and str(path.relative_to(ROOT)) in tracked:
            sources.append(reference(path))
    stat = read(folder / "tespec/statistics.json")
    agent = next(
        (r for r in stat.get("stages", []) if r["stage"] == "agent_proof_filling"), {}
    )
    tokens = stat.get("itp_token_usage", {}).get("total_tokens")
    if tokens is None:
        tokens = agent.get("total_tokens", stat.get("tokens"))
    if tokens is None and "cost_ledger" in stat:
        ledger = checked(stat["cost_ledger"])
        measured = [m for m in ledger["measurements"] if m["tool"] == "tespec"]
        if measured and all(isinstance(m.get("tokens"), int) for m in measured):
            tokens = sum(m["tokens"] for m in measured)
    return {
        "stages": stat.get("stages", stat.get("itp_statistics", {}).get("stages")),
        "model_calls": stat.get("itp_model_calls", stat.get("model_calls")),
        "token_usage": stat.get("itp_token_usage"),
        "measurement_basis": reference(folder / "tespec/statistics.json"),
        "selected_batch_total_tokens": tokens,
        "known_subset_tokens": agent.get("completed_subset_tokens"),
        "sources": sources,
    }


def historical_cases(folder, rows):
    """Point each new execution at the old per-case evidence under its own scope."""
    by_case = defaultdict(list)
    for row in rows:
        row.pop("historical_itp", None)
        for variant in row["cn_pairings"]:
            by_case[variant, row["case"], row["strategy"]].append(row)
    for name, key in (
        ("tespec/results.json", "cases"),
        ("evidence/strategies.json", "decisions"),
        ("evidence/evaluation.json", "executions"),
        ("evidence/tespec-native.json", "runs"),
    ):
        path = folder / name
        if not path.is_file():
            continue
        for index, old in enumerate(read(path).get(key, [])):
            itp_stage = old.get("itp_stage") or {}
            if not (
                itp_stage.get("status") not in (None, "NOT_REQUIRED", "NOT_RUN")
                or any(
                    old.get(field)
                    for field in ("itp", "certificate", "evidence", "itp_receipt")
                )
            ):
                continue
            strategy = old.get("strategy", "inline")
            case = old.get("case", old.get("case_id"))
            variants = old.get("cn_pairings", [old.get("variant")])
            for variant in variants:
                for new in by_case[variant, case, strategy]:
                    ptr = {"path": name, "pointer": f"/{key}/{index}"}
                    refs = new.setdefault("historical_itp", [])
                    if ptr not in refs:
                        refs.append(ptr)


def metric_sum(measurements):
    return {
        "measured": len(measurements),
        "wall_seconds": sum(x["wall_seconds"] for x in measurements)
        if measurements
        else None,
        "max_process_rss_kib": max(
            (
                x["max_process_rss_kib"]
                for x in measurements
                if x.get("max_process_rss_kib") is not None
            ),
            default=None,
        ),
        "tokens": sum(x["tokens"] for x in measurements)
        if measurements and all(isinstance(x.get("tokens"), int) for x in measurements)
        else None,
    }


def main():
    groups = sorted(
        p.name for p in (ROOT / "benchmark/programs").iterdir() if p.is_dir()
    )
    sheets, summary = [], []
    status_count = Counter()
    unexpected = {}
    for group in groups:
        folder = RESULTS / group
        path = folder / "tespec/routes.json"
        data = read(path)
        if group == "dll_add" and not all(
            r["itp_status"] != "UNMEASURED" for r in data["executions"]
        ):
            bind_dll_add(group, data)
        by_strategy = defaultdict(list)
        archive = checked(data["archive"])["executions"] if data["archive"] else None
        for row in data["executions"]:
            by_strategy[row["strategy"]].append(row)
        data["historical_itp"] = historical(folder)
        if group == "runway__funcs2":
            data["sampled_native_errors"] = [
                {
                    "variant": "qcp_existing:0cb8f24f0043303f340c",
                    "case": "increment_Plane_Counter_translation1_0",
                    "strategy": "inline",
                    "diagnostic": "fatal error: too much branches",
                },
                {
                    "variant": "qcp_existing:62db5030dd2d2bfc466e",
                    "case": "arrive_translation4_0",
                    "strategy": "inline",
                    "diagnostic": "fatal error: Cannot use a struct or union program expression as a value in an assertion",
                },
            ]
        historical_cases(folder, data["executions"])
        lines = []
        mismatches = []
        for strategy, rows in sorted(by_strategy.items()):
            native, auto, itp = [], [], []
            for row in rows:
                src = archive[row["archive_row"]] if archive else row
                for bucket, recorded in (
                    (native, src.get("native")),
                    (auto, src.get("auto")),
                    (itp, src.get("itp") if archive else row.get("itp_cost")),
                ):
                    if recorded and isinstance(
                        recorded.get("wall_seconds"), (int, float)
                    ):
                        bucket.append(recorded)
                if not row["expected_match"]:
                    mismatches.append(
                        {
                            k: row.get(k)
                            for k in (
                                "variant",
                                "case",
                                "strategy",
                                "input_sha256",
                                "source_sha256",
                                "goal_sha256",
                                "native_report_sha256",
                                "expected",
                                "native_status",
                                "auto_status",
                                "effective_status",
                                "itp_status",
                                "reason",
                                "failure",
                            )
                        }
                    )
            line = {
                "group": group,
                "strategy": strategy,
                "executions": len(rows),
                "expected_matches": sum(r["expected_match"] for r in rows),
                "native": metric_sum(native),
                "auto_increment": metric_sum(auto),
                "itp": metric_sum(itp),
                "auto_statuses": dict(Counter(r["effective_status"] for r in rows)),
                "itp_statuses": dict(Counter(r["itp_status"] for r in rows)),
            }
            status_count.update(line["auto_statuses"])
            lines.append(line)
        data["summary"]["itp"] = dict(
            Counter(r["itp_status"] for r in data["executions"])
        )
        data["by_strategy"] = lines
        data["unexpected_executions"] = len(mismatches)
        save(path, data)
        if mismatches:
            unexpected[group] = mismatches
        sheets.extend(lines)
        summary.append(
            {
                "group": group,
                "report": reference(path),
                **data["summary"],
                "historical_itp_tokens": data["historical_itp"][
                    "selected_batch_total_tokens"
                ],
                "historical_itp_known_subset": data["historical_itp"][
                    "known_subset_tokens"
                ],
            }
        )
    save(
        RESULTS / "tespec-routes-index.json",
        {
            "schema": "tespec-experiment-routes-index/v1",
            "groups": summary,
            "auto_effective": dict(status_count),
        },
    )
    save(
        RESULTS / "tespec-unexpected/routes-auto.json",
        {
            "schema": "tespec-auto-unexpected/v1",
            "reproduction": "python3 tools/benchmark/organize_tespec_routes.py --group GROUP",
            "groups": unexpected,
        },
    )
    with (RESULTS / "tespec-routes.csv").open(
        "w", newline="", encoding="utf-8"
    ) as stream:
        fields = [
            "group",
            "strategy",
            "executions",
            "expected_matches",
            "auto_statuses",
            "itp_statuses",
        ]
        phases = ("native", "auto_increment", "itp")
        metrics = ("measured", "wall_seconds", "max_process_rss_kib", "tokens")
        writer = csv.DictWriter(
            stream,
            lineterminator="\n",
            fieldnames=fields + [f"{phase}_{m}" for phase in phases for m in metrics],
        )
        writer.writeheader()
        for row in sheets:
            writer.writerow(
                {
                    **{
                        k: json.dumps(row[k], sort_keys=True)
                        if isinstance(row[k], dict)
                        else row[k]
                        for k in fields
                    },
                    **{
                        f"{phase}_{m}": row[phase][m]
                        for phase in phases
                        for m in metrics
                    },
                }
            )
    print(len(groups), sum(status_count.values()), dict(status_count))


if __name__ == "__main__":
    main()
