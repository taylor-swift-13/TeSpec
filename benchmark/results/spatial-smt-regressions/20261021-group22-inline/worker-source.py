#!/usr/bin/env python3
"""Replay complete groups through the real teSpec CLI, without publishing results.

Usage:
  python3 tools/finite_spatial_smt/regress_completed_groups.py --dry-run
  python3 tools/finite_spatial_smt/regress_completed_groups.py --output benchmark/results/spatial-smt-regressions/20261018-integration

Default: every complete group in group-result-cost-index.json, both modes and all
active inputs (currently 21 groups / 900 pairs, including read 61 / array_load 67).
--groups selects an explicitly labelled subset. No CN, Fulminate, ITP, collector,
publisher or formal result files are run/rewritten. Existing ITP is a comparison
oracle only, never a certificate attached to newly generated VCs.

Each fresh worker calls spectest.cli.main with the recorded CLI arguments. Its
sole instrumentation wraps refine_case for time and /proc/self/status VmRSS
sampling every 1 ms, including entry/exit samples. Sampled RSS is not exact.
Entry/exit getrusage high water includes earlier phases. GNU time measures the
complete invocation's largest-process RSS; native executor resources are also
retained. Nested times must not be added. Missing measurements stay null.
"""
from __future__ import annotations

import argparse
from collections import Counter
import csv
import datetime
import functools
import hashlib
import importlib.metadata
import json
import os
from pathlib import Path
import resource
import signal
import subprocess
import sys
import threading
import time

ROOT = Path(__file__).resolve().parents[2]
OUTPUT_ROOT = ROOT / "benchmark/results/spatial-smt-regressions"
OLD_ROOT = "/home/yangfp/teSpec-benchmark-tespec"
STATES = {"PASS", "FAIL", "ERROR", "UNKNOWN"}


def require(condition, message):
    if not condition:
        raise ValueError(message)


def now():
    return datetime.datetime.now(datetime.timezone.utc).isoformat()


def digest(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()


def save(path, data):
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n")


def repo_path(value):
    text = str(value)
    if text == OLD_ROOT or text.startswith(OLD_ROOT + "/"):
        text = str(ROOT) + text[len(OLD_ROOT):]
    path = Path(text)
    path = (path if path.is_absolute() else ROOT / path).resolve()
    require(path.is_relative_to(ROOT), "Reference escapes repository: " + str(value))
    return path


def output_path(value):
    path = repo_path(value)
    require(path != OUTPUT_ROOT and path.is_relative_to(OUTPUT_ROOT.resolve()),
            "Output must be a fresh child of " + str(OUTPUT_ROOT))
    return path


def load(path):
    return json.loads(repo_path(path).read_text())


class Audit:
    """Read-only baseline/input identity registry, checked again after execution."""
    def __init__(self):
        self.files = {}

    def ref(self, value, expected=None):
        path = repo_path(value)
        require(path.is_file(), "Missing evidence: " + str(path))
        sha = digest(path)
        require(expected in (None, sha), "Evidence hash mismatch: " + str(path))
        rel = path.relative_to(ROOT).as_posix()
        require(rel not in self.files or self.files[rel] == sha,
                "Evidence changed during preflight: " + rel)
        self.files[rel] = sha
        return {"path": rel, "sha256": sha}

    def verify(self):
        return [p for p, sha in self.files.items()
                if not (ROOT / p).is_file() or digest(ROOT / p) != sha]


def report_state(measurement, audit):
    ref = audit.ref(measurement["report"], measurement.get("report_sha256"))
    rows = load(ref["path"]).get("results", [])
    require(len(rows) == 1, "Expected one result in " + ref["path"])
    case = rows[0]
    goals = []
    vc = case.get("vc") or {}
    for kind, path in vc.get("files", {}).items():
        if kind in {"goal", "proof_auto", "goal_check"} and path:
            goals.append({"kind": kind, **audit.ref(
                path, vc.get("immutable_sha256", {}).get(kind))})
    status = measurement.get("status", case.get("status"))
    require(status in STATES and status == case.get("status"),
            "Native status/report disagreement: " + ref["path"])
    return {
        "status": status, "published_final_status": measurement.get("final_status", status),
        "reason": case.get("reason"), "precondition_result": case.get("precondition_result"),
        "execution_completed": case.get("execution_completed"),
        "executor_error": case.get("executor_error"), "report": ref,
        "vc_artifacts": goals, "residual_vcs": case.get("residual_vcs", []),
        "command": measurement["command"],
    }


def expected_error(state, guard):
    return (bool(guard) and state["status"] == "ERROR"
            and state.get("reason") == "qcp_execution_error"
            and state.get("precondition_result") == "SAT"
            and guard in json.dumps(state.get("executor_error"), ensure_ascii=False))


def itp_oracle(row, audit, read_case=None):
    """Check source/binding association, without claiming proof reuse."""
    if read_case is not None:
        stage = read_case["itp_stage"]
        if not stage.get("required"):
            return None
        receipt_ref = audit.ref(stage["execution_receipt"])
        receipt = load(receipt_ref["path"])
        binding = receipt["case_binding"]
        require(receipt["status"] == "REFUTED_KERNEL_CHECKED", "Unfinished read ITP")
        require(binding["variant"] == row["variant"] and binding["case"] == row["case"],
                "Wrong read ITP identity")
        audit.ref(binding["original_goal"], binding["original_goal_sha256"])
        audit.ref(binding["proof"], binding["proof_sha256"])
        require(receipt["attempts"][-1]["kernel_check"]["exit_code"] == 0,
                "Read ITP lacks independent kernel check")
        result = binding["resolved_test_status"]
        require(result == read_case["final_result"], "Read ITP conclusion mismatch")
        return {"conclusion": result, "receipt": receipt_ref,
                "status": receipt["status"], "source_mode": "historical_off",
                "scope": "Existing checked conclusion only; no new VC certificate."}
    candidates = []
    for mode in ("off", "on"):
        itp = row["tespec_" + mode].get("itp")
        if not itp:
            continue
        receipt_ref = audit.ref(itp["receipt"], itp.get("receipt_sha256"))
        receipt = load(receipt_ref["path"])
        binding = receipt["binding"]
        require(receipt["status"] == "KERNEL_CHECKED"
                and receipt["kernel_check"]["exit_code"] == 0, "Unfinished ITP")
        require(binding["variant"] == row["variant"] and binding["case"] == row["case"]
                and binding["qcp_source_sha256"] == row["qcp_source_sha256"]
                and binding["binds_sha256"] == row["binds_sha256"],
                "ITP source/input identity mismatch")
        audit.ref(binding["report"], binding["report_sha256"])
        audit.ref(binding["goal"], binding["goal_sha256"])
        audit.ref(binding["binds"], binding["binds_sha256"])
        audit.ref(receipt["candidate"], receipt["candidate_sha256"])
        candidates.append({"conclusion": receipt["final_status"],
                           "receipt": receipt_ref, "source_mode": mode,
                           "status": receipt["status"]})
    if not candidates:
        return None
    require(len({x["conclusion"] for x in candidates}) == 1, "Conflicting ITP conclusions")
    return {"conclusion": candidates[0]["conclusion"], "evidence": candidates,
            "scope": "Existing checked conclusion only; no new VC certificate."}


def manifests(group, audit):
    result = {}
    for path in (ROOT / "benchmark/programs" / group / "variants").glob("*/manifest.json"):
        audit.ref(path)
        value = load(path)
        result[value["id"]] = value
    return result


def source_and_binds(row, variants, audit):
    cn = variants[row["variant"]]["files"]["cn"]
    audit.ref(cn["path"], row["cn_source_sha256"])
    qcp = variants[row["paired_qcp_variant"]]["files"]["qcp"]
    audit.ref(qcp["path"], qcp["sha256"])
    source = audit.ref(qcp["path"], row["qcp_source_sha256"])
    fixture = row.get("qcp_input_fixture")
    if fixture:
        require(fixture["original_source_sha256"] == source["sha256"],
                "Specialized input is not associated with current source")
        source = audit.ref(fixture["path"], fixture["sha256"])
    binds = audit.ref(row["binds"], row["binds_sha256"])
    for include in qcp.get("include_dirs", []):
        directory = repo_path(include)
        require(directory.is_dir(), "Missing include directory: " + include)
        for path in sorted(directory.iterdir()):
            if path.is_file() and path.suffix in {".h", ".strategies"}:
                audit.ref(path)
    for item in row.get("runtime_dependency_fixtures", []):
        audit.ref(item["path"], item["sha256"])
    require(not row.get("qcp_execution_wrapper"),
            "Legacy wrapper may mutate source locators; audit an isolated adapter first.")
    return source, binds


def load_baseline(groups=None, execution_strategy="inline"):
    audit = Audit()
    index_ref = audit.ref("benchmark/results/group-result-cost-index.json")
    index = load(index_ref["path"])
    complete = {g["program_group"] for g in index["groups"] if g["complete"]}
    selected = set(groups) if groups else complete
    require(selected and selected <= complete, "Only complete groups may be selected")
    tasks = []
    for group in sorted(selected):
        variants = manifests(group, audit)
        published_ref = audit.ref("benchmark/results/" + group + "/tespec/results.json")
        published = load(published_ref["path"])
        if group == "read":
            baseline_ref = audit.ref("benchmark/results/read/20261015-spatial-smt/results.json")
            history_ref = audit.ref("benchmark/results/read/20261015-variants/results.json")
            complete_ref = audit.ref(published["complete_result"])
            rows = load(baseline_ref["path"])["runs"]
            originals = {(x["variant"], x["case"]): x for x in load(history_ref["path"])["runs"]}
            finished = {(x["variant"], x["case"]): x for x in load(complete_ref["path"])["cases"]}
            require(len(rows) == len(originals) == len(finished) == 61,
                    "Read coverage changed; review its legacy adapter")
        else:
            baseline_ref = audit.ref(published["evidence"])
            rows = load(baseline_ref["path"])["runs"]
            plan_path = ROOT / "benchmark/programs" / group / "evaluation-plan.json"
            if plan_path.exists():
                plan_ref = audit.ref(plan_path)
                plan = load(plan_ref["path"])
                require(Path(baseline_ref["path"]).parent.name == plan["run_id"],
                        "Published evidence is not the active plan: " + group)
            # Early complete groups predate per-group plans. Their published
            # evidence pointer, current source hashes and frozen row oracle are
            # authoritative; never choose a batch by directory-name recency.
        active_cases = {}
        if group != 'read' and plan_path.exists():
            active_cases = {(pair['cn_variant'], c['id']): c
                            for pair in plan['pairings'] for c in pair.get('cases', [])}
        for position, item in enumerate(rows):
            row = originals[(item["variant"], item["case"])] if group == "read" else item
            source, binds = source_and_binds(row, variants, audit)
            if group == "read":
                require(item["source_sha256"] == source["sha256"]
                        and item["binds_sha256"] == binds["sha256"], "Read mode source mismatch")
                completed = finished[(row["variant"], row["case"])]
                oracle = itp_oracle(row, audit, completed)
                expected = {m: completed["expected_result"] for m in ("off", "on")}
                guard = "cannot read memory" if completed["expected_result"] == "ERROR" else None
                states = {m: report_state(item[m], audit) for m in ("off", "on")}
            else:
                oracle = itp_oracle(row, audit)
                case = row.get("plan_case", row)
                expected = {m: case.get("expected_by_tool", {}).get("tespec_" + m, row["expected"])
                            for m in ("off", "on")}
                guard = case.get("expected_executor_error_contains")
                states = {m: report_state(row["tespec_" + m], audit) for m in ("off", "on")}
            for mode, state in states.items():
                require(expected[mode] in {"PASS", "FAIL", "ERROR"}, "Missing frozen expectation")
                if expected[mode] == "ERROR":
                    require(expected_error(state, guard), "Unclassified baseline ERROR")
                if state["status"] == "UNKNOWN":
                    require(oracle is not None and oracle["conclusion"] == expected[mode],
                            "Complete group's UNKNOWN lacks a matching checked ITP oracle")
            baseline_expected = dict(expected)
            current_case = active_cases.get((row['variant'], row['case']), {})
            strategy_expected = current_case.get('expected_by_execution_strategy', {})
            if execution_strategy in strategy_expected:
                value = strategy_expected[execution_strategy]
                require(value in {'PASS', 'FAIL', 'ERROR'}, 'Invalid strategy expectation')
                expected = {m: value for m in ('off', 'on')}
            task = {"execution_strategy": execution_strategy,
                    "baseline_expected": baseline_expected,
                    "expected_by_execution_strategy": strategy_expected,
                    "group": group, "ordinal": position, "variant": row["variant"],
                    "paired_qcp_variant": row["paired_qcp_variant"], "case": row["case"],
                    "initial": row.get("initial"), "source": source, "binds": binds,
                    "expected": expected, "expected_executor_error_contains": guard,
                    "baseline": states, "itp_comparison_oracle": oracle,
                    "baseline_evidence": baseline_ref}
            for mode in ("off", "on"):
                command_args = cli_arguments(
                    task, mode, OUTPUT_ROOT / "preflight-only" / group / str(position) / mode)
                for i, argument in enumerate(command_args):
                    if argument == "-I":
                        directory = repo_path(command_args[i + 1])
                        require(directory.is_dir(), "Missing recorded include directory")
                        for header in sorted(directory.iterdir()):
                            if header.is_file() and header.suffix in {".h", ".strategies"}:
                                audit.ref(header)
            tasks.append(task)
        require(len(rows) == len({(t["variant"], t["case"]) for t in tasks if t["group"] == group}),
                "Duplicate case identity in " + group)
    counts = dict(Counter(t["group"] for t in tasks))
    if "array_load" in counts:
        require(counts["array_load"] == 67, "array_load full-suite coverage changed; review adapter")
    return tasks, audit, {"complete_groups_available": len(complete),
                          "selected_groups": sorted(selected), "case_pairs_by_group": counts,
                          "case_pairs": len(tasks), "executions": 2 * len(tasks),
                          "full_complete_group_suite": selected == complete}


def cli_arguments(task, mode, destination):
    command = task["baseline"][mode]["command"]
    require(command[1:4] == ["-m", "spectest", "run"], "Unsupported recorded CLI wrapper")
    args = list(command[3:])
    args = [str(repo_path(a)) if (a.startswith(str(ROOT) + "/") or a.startswith(OLD_ROOT + "/"))
            else a for a in args]
    require(repo_path(args[1]) == ROOT / task["source"]["path"], "Recorded source path mismatch")
    require(repo_path(args[args.index("--binds") + 1]) == ROOT / task["binds"]["path"],
            "Recorded binds path mismatch")
    args[args.index("--output-dir") + 1] = str(destination / "artifacts")
    args = [a for a in args if a not in ("--spatial-smt", "--no-spatial-smt")]
    args.append("--spatial-smt" if mode == "on" else "--no-spatial-smt")
    if "--spatial-smt-timeout-ms" not in args:
        args += ["--spatial-smt-timeout-ms", "2000"]
    return args


def classify(baseline, current, expected, guard, oracle, transport_ok=True):
    if not transport_ok:
        return {"ok": False, "kind": "INVOCATION_FAILED", "detail": "Timeout, crash, missing or malformed report."}
    if baseline.get("precondition_result") == "SAT" and current.get("precondition_result") != "SAT":
        return {"ok": False, "kind": "PRECONDITION_REGRESSION"}
    if baseline.get("execution_completed") and not current.get("execution_completed"):
        return {"ok": False, "kind": "EXECUTION_REGRESSION"}
    old, new = baseline["status"], current["status"]
    if old in {"PASS", "FAIL"}:
        return {"ok": new == old, "kind": "UNCHANGED_DECISION" if new == old else "DECISION_REGRESSION"}
    if old == "ERROR":
        good = expected == "ERROR" and expected_error(current, guard)
        return {"ok": good, "kind": "EXPECTED_ERROR_PRESERVED" if good else "ERROR_CLASS_REGRESSION"}
    if new == "UNKNOWN":
        return {"ok": True, "kind": "UNKNOWN_REMAINS", "resolved": False}
    good = (new in {"PASS", "FAIL"} and new == expected and oracle is not None
            and new == oracle["conclusion"])
    return {"ok": good, "kind": "IMPROVED_MATCHES_ITP" if good else "UNKNOWN_CONTRADICTS_ORACLE",
            "resolved": good, "certificate_reused": False}


def strategy_comparison(comparison, current, expected, transport_ok):
    """An oracle change never hides entry/transport/execution regressions."""
    if comparison["kind"] in {"INVOCATION_FAILED", "PRECONDITION_REGRESSION", "EXECUTION_REGRESSION"}:
        return comparison
    matched = transport_ok and current.get("status") == expected
    return {"ok": matched,
            "kind": "STRATEGY_EXPECTATION_MATCH" if matched else "STRATEGY_EXPECTATION_PENDING"}


def resident_kib():
    for line in Path("/proc/self/status").read_text().splitlines():
        if line.startswith("VmRSS:"):
            return int(line.split()[1])
    return None


def worker(phase_path, cli_args):
    """Only measurement surrounds the same CLI and refinement functions."""
    phase_path = output_path(phase_path)
    sys.path.insert(0, str(ROOT))
    import spectest.spatial_smt as spatial
    from spectest.cli import main as cli_main
    original = spatial.refine_case
    phases = []

    @functools.wraps(original)
    def measured(*args, **kwargs):
        stop = threading.Event()
        samples = []
        def sample():
            value = resident_kib()
            if value is not None:
                samples.append(value)
        def poll():
            while not stop.wait(0.001):
                sample()
        entry_hwm = resource.getrusage(resource.RUSAGE_SELF).ru_maxrss
        sample()
        monitor = threading.Thread(target=poll, daemon=True)
        start = time.monotonic()
        monitor.start()
        try:
            return original(*args, **kwargs)
        finally:
            elapsed = time.monotonic() - start
            sample()
            stop.set()
            monitor.join()
            case = args[0] if args else {}
            info = case.get("spatial_smt") or {}
            phases.append({
                "stage": "spatial_smt_refinement", "wall_seconds": elapsed,
                "solver_reported_wall_seconds": info.get("wall_seconds"),
                "attempted": info.get("attempted"),
                "sampled_peak_process_rss_kib": max(samples) if samples else None,
                "samples": len(samples), "sampling_interval_ms": 1,
                "process_lifetime_high_water_rss_kib_at_entry": entry_hwm,
                "process_lifetime_high_water_rss_kib_at_exit":
                    resource.getrusage(resource.RUSAGE_SELF).ru_maxrss,
                "rss_scope": "Worker VmRSS during stage, including entry/exit: observed peak, not exact. High-water values cover process lifetime including earlier phases.",
                "tokens": 0, "model_calls": 0,
            })
            save(phase_path, {"schema": "tespec-regression-phase-measurement/v1", "phases": phases})
    spatial.refine_case = measured
    sys.argv = ["spectest", *cli_args]
    try:
        return cli_main()
    finally:
        spatial.refine_case = original
        save(phase_path, {"schema": "tespec-regression-phase-measurement/v1", "phases": phases})


def measure(command, folder, timeout):
    folder.mkdir(parents=True, exist_ok=False)
    resource_file = folder / "resources.json"
    wrapper = ["/usr/bin/time", "--quiet", "-f",
               '{"max_process_rss_kib":%M,"user_seconds":%U,"system_seconds":%S,"wall_seconds_gnu":%e}',
               "-o", str(resource_file), "/usr/bin/timeout", "--signal=TERM", "--kill-after=5",
               str(timeout), *command]
    start = time.monotonic()
    with (folder / "stdout.log").open("wb") as stdout, (folder / "stderr.log").open("wb") as stderr:
        proc = subprocess.Popen(wrapper, cwd=ROOT, env={**os.environ, "PYTHONDONTWRITEBYTECODE": "1"},
                                stdout=stdout, stderr=stderr, start_new_session=True)
        try:
            code = proc.wait(timeout=timeout + 10)
        except subprocess.TimeoutExpired:
            os.killpg(proc.pid, signal.SIGKILL)
            proc.wait()
            code = 124
        except KeyboardInterrupt:
            os.killpg(proc.pid, signal.SIGKILL)
            proc.wait()
            raise
    resources = None
    if resource_file.exists():
        try:
            resources = json.loads(resource_file.read_text())
        except (ValueError, OSError):
            pass
    return {"command": command, "executed_wrapper_command": wrapper, "exit_code": code,
            "wall_seconds": time.monotonic() - start, "resources": resources,
            "tokens": 0, "model_calls": 0,
            "stdout": str((folder / "stdout.log").relative_to(ROOT)),
            "stderr": str((folder / "stderr.log").relative_to(ROOT)),
            "memory_definition": "GNU time %M: largest measured process peak RSS, not aggregate tree memory."}


def run_task(task, mode, out, timeout):
    folder = out / task["group"] / ("case-%04d" % task["ordinal"]) / mode
    args = cli_arguments(task, mode, folder)
    phase_file = folder / "phase-metrics.json"
    command = [sys.executable, "-B", str(Path(__file__).resolve()), "--_worker",
               str(phase_file), "--", *args]
    measurement = measure(command, folder, timeout)
    report_path = folder / "artifacts/report.json"
    current = {"status": "UNKNOWN", "reason": "invocation_failed"}
    transport_ok = False
    report_ref = None
    goals = []
    executor = None
    if report_path.exists():
        report_ref = {"path": str(report_path.relative_to(ROOT)), "sha256": digest(report_path)}
        try:
            data = json.loads(report_path.read_text())
            case = data["results"][0]
            transport_ok = (measurement["exit_code"] in (0, 1) and len(data["results"]) == 1
                            and case.get("status") in STATES)
            current = {k: case.get(k) for k in (
                "status", "reason", "precondition_result", "execution_completed",
                "executor_error", "residual_vcs", "phases", "spatial_smt")}
            for kind, path in (case.get("vc") or {}).get("files", {}).items():
                if kind in {"goal", "proof_auto", "goal_check"} and path and Path(path).is_file():
                    goals.append({"kind": kind, "path": str(Path(path).relative_to(ROOT)),
                                  "sha256": digest(path)})
            executor = case.get("resources")
        except (ValueError, KeyError, IndexError, TypeError):
            transport_ok = False
    measured_phases = json.loads(phase_file.read_text())["phases"] if phase_file.exists() else []
    comparison = classify(task["baseline"][mode], current, task["expected"][mode],
                          task["expected_executor_error_contains"], task["itp_comparison_oracle"],
                          transport_ok=transport_ok)
    if task.get("baseline_expected", task["expected"])[mode] != task["expected"][mode]:
        comparison = strategy_comparison(comparison, current, task["expected"][mode], transport_ok)
    result = {"execution_strategy": task.get("execution_strategy", "inline"),
              "baseline_expected": task.get("baseline_expected", task["expected"])[mode],
              "group": task["group"], "variant": task["variant"],
              "paired_qcp_variant": task["paired_qcp_variant"], "case": task["case"], "mode": mode,
              "source": task["source"], "binds": task["binds"],
              "expected": task["expected"][mode], "baseline": task["baseline"][mode],
              "itp_comparison_oracle": task["itp_comparison_oracle"],
              "current": current, "comparison": comparison, "measurement": measurement,
              "report": report_ref, "vc_artifacts": goals,
              "stage_measurements": {
                  "native_cli": {"wall_seconds": measurement["wall_seconds"],
                                 "resources": measurement["resources"], "tokens": 0, "model_calls": 0},
                  "symbolic_executor": executor,
                  "spatial_smt": measured_phases,
                  "scope": "Nested stages, not additive. Executor resources from native report. No ITP rerun; historical ITP cost excluded."}}
    for name in ("stdout", "stderr"):
        measurement[name + "_sha256"] = digest(ROOT / measurement[name])
    save(folder / "receipt.json", result)
    return result


def summarize(rows, coverage, audit_changes, complete):
    counts = Counter(x["comparison"]["kind"] for x in rows)
    totals = {}
    for mode in ("off", "on"):
        selected = [x for x in rows if x["mode"] == mode]
        rss = [x["measurement"]["resources"]["max_process_rss_kib"] for x in selected
               if x["measurement"].get("resources")]
        totals[mode] = {
            "executions": len(selected), "native_statuses": dict(Counter(x["current"]["status"] for x in selected)),
            "wall_seconds_sum": sum(x["measurement"]["wall_seconds"] for x in selected),
            "max_process_rss_kib": max(rss) if rss else None,
            "tokens": 0, "model_calls": 0,
        }
    return {"coverage": coverage, "completed_executions": len(rows), "run_complete": complete,
            "comparison_counts": dict(counts), "regressions": sum(not x["comparison"]["ok"] for x in rows),
            "unchanged_evidence": not audit_changes, "changed_evidence": audit_changes,
            "passed": complete and not audit_changes and all(x["comparison"]["ok"] for x in rows),
            "modes": totals, "scope": "Native regression only. UNKNOWN_REMAINS is not a successful decision."}


def publish_local(out, rows, coverage, audit_changes, complete):
    summary = summarize(rows, coverage, audit_changes, complete)
    save(out / "results.json", {"schema": "tespec-completed-group-native-regression/v1",
                               "updated_utc": now(), "summary": summary, "runs": rows})
    save(out / "summary.json", summary)
    differences = [x for x in rows if x["current"]["status"] != x["baseline"]["status"]
                   or not x["comparison"]["ok"]]
    save(out / "differences.json", differences)
    with (out / "results.csv").open("w", newline="") as f:
        writer = csv.writer(f)
        writer.writerow(["group", "variant", "case", "mode", "expected", "old_native", "new_native",
                         "comparison", "ok", "wall_seconds", "max_process_rss_kib", "tokens"])
        for x in rows:
            writer.writerow([x["group"], x["variant"], x["case"], x["mode"], x["expected"],
                             x["baseline"]["status"], x["current"]["status"], x["comparison"]["kind"],
                             x["comparison"]["ok"], x["measurement"]["wall_seconds"],
                             (x["measurement"].get("resources") or {}).get("max_process_rss_kib"), 0])
    lines = ["# Completed-group native regression", "",
             "Full CLI executions in fresh output directories; formal benchmark evidence is read-only.",
             "Existing ITP is a comparison oracle and is not reused as a new certificate.", "",
             "- Complete suite selected: " + str(coverage["full_complete_group_suite"]),
             "- Groups / input pairs / executed mode runs: %d / %d / %d" %
             (len(coverage["selected_groups"]), coverage["case_pairs"], len(rows)),
             "- Run complete: " + str(complete),
             "- Regressions: " + str(summary["regressions"]),
             "- Baseline and input hashes unchanged: " + str(not audit_changes),
             "- Regression gate passed: " + str(summary["passed"]), "",
             "UNKNOWN_REMAINS is preserved incompleteness, never a successful check. Timeout/crash is a regression.",
             "Times are nested: CLI total, executor resources and spatial stage must not be summed.",
             "Spatial RSS is a 1 ms observed VmRSS peak; entry/exit process high water includes preceding phases.",
             "tokens=0 describes this native run only; no model or ITP calls were made.", "",
             "| Comparison | Executions |", "| --- | ---: |"]
    lines += ["| %s | %s |" % x for x in sorted(summary["comparison_counts"].items())]
    (out / "summary.md").write_text("\n".join(lines) + "\n")
    return summary


def main():
    if sys.argv[1:2] == ["--_worker"]:
        require(len(sys.argv) > 4 and sys.argv[3] == "--", "Invalid worker arguments")
        return worker(sys.argv[2], sys.argv[4:])
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--groups", nargs="+", help="Explicit subset; omitted means all complete groups.")
    parser.add_argument("--dry-run", action="store_true", help="Validate baseline hashes, print coverage; execute nothing.")
    parser.add_argument("--timeout", type=int, default=90, help="Whole CLI timeout per mode, seconds.")
    args = parser.parse_args()
    require(1 <= args.timeout <= 600, "Timeout must be 1..600 seconds")
    tasks, audit, coverage = load_baseline(args.groups)
    if args.dry_run:
        print(json.dumps({**coverage, "baseline_files_checked": len(audit.files),
                          "executed": False, "unchanged": not audit.verify()}, indent=2))
        return 0
    require(args.output is not None, "--output is required unless --dry-run")
    out = output_path(args.output)
    require(not out.exists(), "Never overwrite or resume a run; choose a fresh --output")
    out.mkdir(parents=True, exist_ok=False)
    for folder in (ROOT / "spectest", ROOT / "tools/finite_spatial_smt"):
        for path in sorted(folder.rglob("*.py")):
            audit.ref(path)
    for path in (ROOT / "bin/tespec-symexec", ROOT / "bin/tespec-symexec.build.json"):
        audit.ref(path)
    (out / "worker-source.py").write_bytes(Path(__file__).read_bytes())
    save(out / "baseline.json", {"schema": "tespec-regression-baseline/v1", "recorded_utc": now(),
                                "coverage": coverage, "inputs": tasks, "immutable_sha256": audit.files})
    save(out / "provenance.json", {
        "started_utc": now(), "git_head": subprocess.check_output(
            ["git", "rev-parse", "HEAD"], cwd=ROOT, text=True).strip(),
        "python": sys.version, "z3_version": importlib.metadata.version("z3-solver"),
        "worker_source": "worker-source.py", "worker_source_sha256": digest(Path(__file__)),
        "current_module_sha256": {p: sha for p, sha in audit.files.items()
                                 if p.startswith(("spectest/", "tools/finite_spatial_smt/"))},
        "instrumentation": "Same spectest.cli.main; refine_case only surrounded by time/RSS measurement.",
    })
    rows = []
    complete = False
    try:
        for ordinal, task in enumerate(tasks):
            for mode in ("off", "on"):
                rows.append(run_task(task, mode, out, args.timeout))
            if (len(rows) % 100 == 0 or ordinal == len(tasks) - 1
                    or tasks[ordinal + 1]["group"] != task["group"]):
                publish_local(out, rows, coverage, [], False)
                print("%s %s %s: %s -> %s / %s -> %s" % (
                    task["group"], task["variant"], task["case"],
                    rows[-2]["baseline"]["status"], rows[-2]["current"]["status"],
                    rows[-1]["baseline"]["status"], rows[-1]["current"]["status"]), flush=True)
        complete = len(rows) == coverage["executions"]
    finally:
        summary = publish_local(out, rows, coverage, audit.verify(), complete)
    print(json.dumps(summary, indent=2))
    return 0 if summary["passed"] else 1


if __name__ == "__main__":
    raise SystemExit(main())
