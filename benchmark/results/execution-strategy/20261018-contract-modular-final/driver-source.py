#!/usr/bin/env python3
"""Measure singleton/dll_add across execution strategy, VC policy and spatial SMT.
Original sources, expectations and inputs are immutable. This is a native
regression report, not a replacement for universal CN/QCP or ITP certificates.
"""
from __future__ import annotations
import argparse
from collections import Counter
import csv
import json
import statistics
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from tools.finite_spatial_smt import regress_completed_groups as shared_measurement
from tools.finite_spatial_smt.regress_completed_groups import (
    Audit, digest, measure, now, save,
)

GROUPS = ("Dbl_Linked_List__singleton", "dll_add")
WORKER = ROOT / "tools/finite_spatial_smt/regress_completed_groups.py"


def publish_group_costs(results, out):
    for group in GROUPS:
        table = []
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                for spatial in ("off", "on"):
                    xs = [x for x in results if (x["group"], x["execution_strategy"], x["vc_mode"], x["spatial_smt_mode"]) == (group, strategy, mode, spatial)]
                    es = [x["stage_measurements"]["executor"] for x in xs if x["stage_measurements"]["executor"]]
                    counts = Counter(x["status"] for x in xs)
                    table.append({
                        "strategy": strategy, "vc_mode": mode, "spatial_smt": spatial,
                        "executions": len(xs), "execution_completed": sum(x["execution_completed"] is True for x in xs),
                        **{k: counts[k] for k in ("PASS", "UNKNOWN", "FAIL", "ERROR")},
                        "cli_wall_seconds_mean": statistics.mean(x["measurement"]["wall_seconds"] for x in xs),
                        "cli_max_process_rss_kib_max": max(x["measurement"]["resources"]["max_process_rss_kib"] for x in xs),
                        "executor_wall_seconds_mean": statistics.mean(x["wall_seconds"] for x in es) if es else None,
                        "executor_max_process_rss_kib_max": max(x["peak_rss_kib"] for x in es) if es else None,
                        "tokens": 0, "itp": "NOT_RUN",
                    })
        folder = out / group
        save(folder / "result-cost.json", {
            "schema": "tespec-strategy-result-cost/v1", "group": group,
            "scope": "Supplemental native execution strategy tests only; CN/QCP/Fulminate and ITP not rerun.",
            "rows": table,
            "cost_semantics": "Per-execution means; maximum process peak RSS per row. Nested stages must not be added. Spatial stage metrics remain in each receipt.",
        })
        with (folder / "result-cost.csv").open("w", newline="") as f:
            writer = csv.DictWriter(f, fieldnames=list(table[0]))
            writer.writeheader()
            writer.writerows(table)
        lines = ["# " + group + " — execution strategy costs", "",
                 "Supplemental native tests; no new universal or ITP certificate.",
                 "Time is per-execution mean. RSS is largest process peak. CLI/executor times are nested. Tokens=0 for this native run.", "",
                 "| Strategy | VC mode | SMT | Runs | PASS / UNKNOWN / FAIL / ERROR | CLI mean s | CLI peak KiB | Executor mean s | Executor peak KiB |",
                 "| --- | --- | --- | ---: | --- | ---: | ---: | ---: | ---: |"]
        for x in table:
            lines.append("| %s | %s | %s | %d | %d / %d / %d / %d | %.6f | %d | %s | %s |" % (
                x["strategy"], x["vc_mode"], x["spatial_smt"], x["executions"],
                x["PASS"], x["UNKNOWN"], x["FAIL"], x["ERROR"],
                x["cli_wall_seconds_mean"], x["cli_max_process_rss_kib_max"],
                x["executor_wall_seconds_mean"], x["executor_max_process_rss_kib_max"]))
        (folder / "result-cost.md").write_text("\n".join(lines) + "\n")


def main():
    if sys.argv[1:2] == ["--_worker"]:
        if len(sys.argv) < 5 or sys.argv[3] != "--":
            raise ValueError("invalid worker arguments")
        shared_measurement.OUTPUT_ROOT = ROOT / "benchmark/results/execution-strategy"
        return shared_measurement.worker(sys.argv[2], sys.argv[4:])
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", required=True, type=Path)
    parser.add_argument("--qcp-binary", type=Path, default=ROOT / "bin/tespec-symexec")
    args = parser.parse_args()
    out = args.output.resolve()
    permitted = (ROOT / "benchmark/results/execution-strategy").resolve()
    if out == permitted or not out.is_relative_to(permitted) or out.exists():
        parser.error("output must be a fresh child of benchmark/results/execution-strategy")
    binary = args.qcp_binary.resolve()
    out.mkdir(parents=True)
    audit = Audit()
    binary_sha = digest(binary)
    modules = {str(p.relative_to(ROOT)): digest(p) for p in (ROOT / "spectest").glob("*.py")}
    save(out / "provenance.json", {
        "schema": "tespec-execution-strategy-regression/v1", "started_utc": now(),
        "binary": str(binary), "binary_sha256": binary_sha,
        "driver_sha256": digest(__file__), "measurement_worker_sha256": digest(WORKER),
        "modules": modules, "scope": "Actual native tests; no model calls, no new ITP or universal certificate.",
    })
    results = []
    for group in GROUPS:
        baseline_path = ROOT / "benchmark/results" / group / "20261016-evaluation/results.json"
        audit.ref(baseline_path)
        baseline = json.loads(baseline_path.read_text())
        for ordinal, old in enumerate(baseline["runs"]):
            original = old["tespec_off"]["command"]
            source = Path(original[4])
            audit.ref(source, old["qcp_source_sha256"])
            audit.ref(old["binds"], old["binds_sha256"])
            for strategy in ("inline", "modular"):
                for mode in ("entry-exit", "all-boundaries"):
                    for spatial in ("off", "on"):
                        folder = out / group / ("%02d-" % ordinal + old["case"]) / strategy / mode / spatial
                        cli = original[3:]
                        cli[cli.index("--output-dir") + 1] = str(folder / "artifacts")
                        cli[cli.index("--execution-mode") + 1] = mode
                        cli[cli.index("--no-spatial-smt")] = "--spatial-smt" if spatial == "on" else "--no-spatial-smt"
                        cli += ["--qcp-binary", str(binary), "--execution-strategy", strategy]
                        phase_path = folder / "phase-metrics.json"
                        command = [sys.executable, "-B", str(Path(__file__).resolve()), "--_worker",
                                   str(phase_path), "--", *cli]
                        measurement = measure(command, folder, 90)
                        report_path = folder / "artifacts/report.json"
                        report = json.loads(report_path.read_text()) if report_path.exists() else {}
                        cases = report.get("results", [])
                        case = cases[0] if len(cases) == 1 else {}
                        ok_transport = (measurement["exit_code"] in (0, 1) and len(cases) == 1)
                        row = {
                            "group": group, "variant": old["variant"], "case": old["case"],
                            "source": str(source.relative_to(ROOT)), "source_sha256": digest(source),
                            "binds": old["binds"], "binds_sha256": old["binds_sha256"],
                            "expected": old["expected"], "execution_strategy": strategy,
                            "vc_mode": mode, "spatial_smt_mode": spatial,
                            "status": case.get("status", "NOT_RUN"),
                            "reason": case.get("reason", "invocation_failed"),
                            "execution_completed": case.get("execution_completed"),
                            "result_scope": case.get("result_scope"),
                            "matches_expected": ok_transport and case.get("status") == old["expected"],
                            "native": {k: case.get(k) for k in (
                                "executor_reported_status", "precondition_result", "residual_vcs",
                                "vc_results", "sampling_events", "abstraction_events", "spatial_smt")},
                            "measurement": measurement,
                            "report": str(report_path.relative_to(ROOT)) if report else None,
                            "report_sha256": digest(report_path) if report else None,
                            "stage_measurements": {
                                "executor": case.get("resources"),
                                "spatial_smt": json.loads(phase_path.read_text())["phases"] if phase_path.exists() else [],
                                "tokens": 0, "model_calls": 0,
                                "itp": "NOT_RUN", "scope": "CLI, executor and spatial stages are nested, not additive.",
                            },
                        }
                        save(folder / "receipt.json", row)
                        results.append(row)
                        save(out / "results.json", {"complete": False, "runs": results})
                        if not ok_transport:
                            raise RuntimeError("Native invocation missing or malformed; stopped at " + str(folder))
        print(group, len([x for x in results if x["group"] == group]), "executions", flush=True)
    changed = audit.verify()
    stable = digest(binary) == binary_sha and all(digest(ROOT / p) == sha for p, sha in modules.items())
    summary = {
        "finished_utc": now(), "complete": True, "executions": len(results),
        "completed_native_executions": sum(x["execution_completed"] is True for x in results),
        "statuses": dict(Counter(x["status"] for x in results)),
        "matched": sum(x["matches_expected"] for x in results),
        "unmatched": sum(not x["matches_expected"] for x in results),
        "input_evidence_unchanged": not changed, "changed_evidence": changed,
        "binary_and_modules_unchanged": stable,
        "tokens": 0, "model_calls": 0, "new_itp_certificates": 0, "invocation_failures": sum(x["status"] == "NOT_RUN" for x in results),
    }
    save(out / "results.json", {"summary": summary, "runs": results})
    save(out / "input-audit.json", audit.files)
    save(out / "summary.json", summary)
    with (out / "results.csv").open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["group", "variant", "case", "strategy", "vc_mode", "spatial_smt",
                         "expected", "native_final", "matched", "cli_seconds", "cli_peak_rss_kib",
                         "executor_seconds", "executor_peak_rss_kib", "tokens"])
        for x in results:
            e = x["stage_measurements"]["executor"] or {}
            writer.writerow([x["group"], x["variant"], x["case"], x["execution_strategy"],
                             x["vc_mode"], x["spatial_smt_mode"], x["expected"], x["status"],
                             x["matches_expected"], x["measurement"]["wall_seconds"],
                             (x["measurement"]["resources"] or {}).get("max_process_rss_kib"),
                             e.get("wall_seconds"), e.get("peak_rss_kib"), 0])
    lines = ["# Execution strategy target regression", "",
             "Native results only. Original source, expectations and inputs preserved.",
             "No universal verification or ITP certificate is implied by PASS.", "",
             "| Group | Strategy | VC mode | SMT | Executions | PASS | UNKNOWN | FAIL/ERROR |",
             "| --- | --- | --- | --- | ---: | ---: | ---: | ---: |"]
    for group in GROUPS:
        for strategy in ("inline", "modular"):
            for mode in ("entry-exit", "all-boundaries"):
                for spatial in ("off", "on"):
                    selected = [x for x in results if (x["group"], x["execution_strategy"], x["vc_mode"], x["spatial_smt_mode"]) == (group, strategy, mode, spatial)]
                    counts = Counter(x["status"] for x in selected)
                    lines.append("| %s | %s | %s | %s | %d | %d | %d | %d |" % (
                        group, strategy, mode, spatial, len(selected), counts["PASS"],
                        counts["UNKNOWN"], counts["FAIL"] + counts["ERROR"]))
    (out / "summary.md").write_text("\n".join(lines) + "\n")
    publish_group_costs(results, out)
    print(json.dumps(summary))
    return 0 if stable and not changed else 1


if __name__ == "__main__":
    raise SystemExit(main())
