#!/usr/bin/env python3
"""Read-only audit of compact group results and independently checked ITP receipts.

This validates recorded evidence and cost completeness; it never reruns a prover
or silently upgrades native UNKNOWN. Older publication formats keep their own
validation path in validate_group_evaluation.py.
"""
from __future__ import annotations

import csv
import hashlib
import json
import math
from pathlib import Path
import re
import statistics
import sys

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT))
from spectest.certificates import (
    ASSUMPTION_IDENTITIES, TRUSTED_ASSUMPTIONS, assumption_audit_from_output,
    check_candidate_commands, goal_interface, coverage_source,
)

SCHEMA = "tespec-canonical-group-evaluation/v1"
ITP_SCHEMA = "tespec-canonical-execution-itp/v1"
from singleton_canonical_support import (PROFILE, audit_strong_binding, combine_metrics,
    legacy_costs, native_cost, audit_transition, canonical_sha)


def need(condition, message):
    if not condition:
        raise ValueError(message)


def load(path):
    return json.loads(path.read_text())


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def hash_value(value, label):
    need(isinstance(value, str) and re.fullmatch(r"[0-9a-f]{64}", value),
         "Missing or malformed SHA-256: " + label)
    return value


def path_in(root, value):
    need(isinstance(value, str), "Evidence path must be a string")
    path = (root / value).resolve()
    need(path.is_relative_to(root.resolve()) and path.is_file(),
         "Missing or out-of-repository evidence: " + value)
    return path


def ref(root, value):
    need(isinstance(value, dict), "Expected a path/SHA-256 evidence reference")
    path = path_in(root, value.get("path"))
    need(digest(path) == hash_value(value.get("sha256"), str(path)),
         "Evidence hash mismatch: " + str(path))
    return path


def number(value, label, positive=False):
    need(type(value) in (int, float) and math.isfinite(value)
         and (value > 0 if positive else value >= 0), "Missing measurement: " + label)


def measurement(value, label, successful=False):
    need(isinstance(value, dict), "Missing measurement object: " + label)
    number(value.get("wall_seconds"), label + " wall time")
    rss = value.get("resources") or {}
    number(rss.get("max_process_rss_kib"), label + " peak RSS", positive=True)
    need("exit_code" in value, "Missing exit status: " + label)
    if successful:
        need(value["exit_code"] == 0, "Unsuccessful stage: " + label)


def attempt_measurement(value, label, allow_missing_rss=False):
    """Permit an explicitly incomplete failed attempt, never a successful stage."""
    resources = value.get("resources") or {}
    if resources.get("max_process_rss_kib") is not None:
        measurement(value, label)
        return False
    need(allow_missing_rss and value.get("exit_code") not in (None, 0),
         "Missing RSS is only publishable as an incomplete failed attempt: " + label)
    number(value.get("wall_seconds"), label + " measured failed wall time")
    return True


def audited_log(root, measurement, name):
    path = path_in(root, measurement[name])
    need(digest(path) == hash_value(measurement.get(name + "_sha256"), str(path)),
         "Historical log hash mismatch: " + str(path))
    return path.read_text()


def model_attempt(value, label):
    need(value.get("requested_model") == "gpt-6.1-sol", "Wrong model: " + label)
    number(value.get("wall_seconds"), label + " agent time")
    resources = value.get("resources") or {}
    if "max_process_peak_working_set_bytes" in resources:
        number(resources["max_process_peak_working_set_bytes"], label + " client RSS", True)
    else:
        number(resources.get("max_process_rss_kib"), label + " client RSS", True)
    need("exit_code" in value, "Missing model exit code: " + label)
    usage = value.get("token_usage")
    need(isinstance(usage, list) and usage, "Missing actual token usage: " + label)
    for item in usage:
        for name in ("input_tokens", "output_tokens"):
            need(type(item.get(name)) is int and item[name] >= 0,
                 "Invalid token measurement: " + label)
        for sub, total in (("cached_input_tokens", "input_tokens"),
                           ("reasoning_output_tokens", "output_tokens")):
            if sub in item:
                need(type(item[sub]) is int and 0 <= item[sub] <= item[total],
                     "Invalid token subset: " + label)
    hash_value(value.get("raw_event_log_sha256"), label + " actual CLI event log")
    hash_value(value.get("prompt_sha256"), label + " prompt")
    hash_value(value.get("candidate_sha256"), label + " candidate")
    events = value.get("usage_events")
    if events is not None:
        need([event["usage"] for event in events if event.get("type") == "turn.completed"] == usage,
             "Token totals do not match CLI events: " + label)
    return sum(item["input_tokens"] + item["output_tokens"] for item in usage)


def audit_cn(root, publication, group, source_hashes, function):
    source = publication["source"]
    source = source if isinstance(source, dict) else {
        "path": source, "sha256": publication["source_sha256"]}
    source_path = ref(root, source)
    need(source_hashes.get(str(source_path.relative_to(root))) == source["sha256"],
         "CN source is not an active variant")
    verdict = publication["verdict"]
    need(verdict == "VERIFIED" or (group == "Dbl_Linked_List__singleton"
         and verdict == "VERIFIED_WITH_COMPAT_HEADERS"), "Unsupported CN success qualification")
    receipt_path = ref(root, {"path": publication["evidence"],
                             "sha256": publication["evidence_sha256"]})
    receipt = load(receipt_path)
    m = receipt.get("cn", receipt)
    measurement(m, "CN verification", successful=True)
    need("verify" in m.get("command", []) and str(source_path) in m["command"],
         "CN verification command names another source")
    log = path_in(root, m["stdout"]).read_text()
    need(re.search(r"\b" + re.escape(function) + r"\s+--\s+pass\b", log),
         "CN log does not verify the designated function")
    if verdict == "VERIFIED_WITH_COMPAT_HEADERS":
        need(not re.search(r"\btrusted\b", source_path.read_text()),
             "CN compatible source unexpectedly skips verification")
        compatibility = load(ref(root, {"path": publication["compatibility_manifest"],
                                       "sha256": publication["compatibility_manifest_sha256"]}))
        for item in compatibility["files"]:
            for side in ("original", "adapted"):
                ref(root, {"path": item[side], "sha256": item[side + "_sha256"]})
        for item in compatibility["runtime_files"]:
            ref(root, item)
        for name in publication["verified_functions"]:
            need(re.search(r"\b" + re.escape(name) + r"\s+--\s+pass\b", log),
                 "Missing compatible dependency verification: " + name)
    return receipt


def audit_fulminate(root, publication, cases):
    receipt = load(ref(root, {"path": publication["evidence"],
                              "sha256": publication["evidence_sha256"]}))
    rows = receipt["runs"]
    need(len(rows) == len(cases), "Incomplete Fulminate input coverage")
    seen = set()
    for row in rows:
        key = (row["variant"], row["case"])
        need(key in cases and key not in seen, "Unknown or duplicate Fulminate input")
        seen.add(key)
        case, pair = cases[key]
        need(row["paired_qcp_variant"] == pair["qcp_variant"], "Fulminate pairing mismatch")
        need(row["element"] == case["value"], "Fulminate input mismatch")
        expected = case.get("expected_by_tool", {}).get("fulminate_test", case["expected"])
        need(row["expected"] == expected, "Fulminate oracle changed")
        harness = ref(root, {"path": row["harness"], "sha256": row["harness_sha256"]})
        need(case["cn_body"] in harness.read_text(), "Fulminate harness executes a different case")
        measurement(row["pipeline"], "Fulminate pipeline " + row["case"], successful=True)
        measurement(row["test"], "Fulminate execution " + row["case"])
        actual = row["test"]["status"]
        need(actual == expected, "Unresolved Fulminate result mismatch")
        need((row["test"]["exit_code"] == 0) == (actual == "PASS"),
             "Fulminate exit/status mismatch")
    need(publication["summary"]["case_pairs"] == len(cases), "Fulminate summary denominator")
    return receipt


def audit_qcp(root, publication, source_hashes):
    source = publication["source"]
    source = source if isinstance(source, dict) else {
        "path": source, "sha256": publication["source_sha256"]}
    source_path = ref(root, source)
    need(source_hashes.get(str(source_path.relative_to(root))) == source["sha256"],
         "QCP source is not an active variant")
    receipt_path = path_in(root, publication["receipt"])
    receipt = load(receipt_path)
    need(receipt["status"] == "VERIFIED_KERNEL_CHECKED", "QCP proof incomplete")
    original = ref(root, {"path": receipt["original_goal"],
                          "sha256": receipt["original_goal_sha256"]})
    ref(root, {"path": receipt["goal"], "sha256": receipt["original_goal_sha256"]})
    candidate = ref(root, {"path": receipt["proof"], "sha256": receipt["proof_sha256"]})
    check_candidate_commands(candidate.read_text())
    entries = goal_interface(original.read_text())
    need([name for name, _ in entries] == publication["original_vc_correct_targets"],
         "QCP original interface coverage changed")
    need(len(entries) == publication["obligations"] == len(receipt["obligations"]),
         "QCP original obligation count mismatch")
    need({statement for _, statement in entries} == set(receipt["obligations"]),
         "QCP receipt omits an original obligation")
    need(re.search(r"Module\s+\w+\s*:\s*PrimaryQcpGoal\.VC_Correct\s*\.", candidate.read_text()),
         "QCP candidate lacks the original complete interface implementation")
    for item in receipt.get("proof_context", {}).get("files", []):
        ref(root, {"path": item["original_source"], "sha256": item["sha256"]})
    for stage in receipt["compilation"]:
        measurement(stage, "QCP compile attempt")
        for stream in ("stdout", "stderr"):
            audited_log(root, stage, stream)
    kernel = receipt["kernel_check"]
    measurement(kernel, "QCP independent kernel", successful=True)
    for stream in ("stdout", "stderr"):
        audited_log(root, kernel, stream)
    audit = path_in(root, receipt["assumptions"]["raw_audit"]).read_text()
    names, unsupported = assumption_audit_from_output(audit)
    # This pre-existing receipt prints its original type parameter unqualified.
    # It is a historical scope qualification, not a new checker allowlist.
    legacy = receipt["assumptions"]
    allowed = set(TRUSTED_ASSUMPTIONS)
    if legacy.get("allowed_runtime_parameters") == ["eval_addr_expr : rvalue_expr -> addr"]:
        allowed.add("eval_addr_expr")
    need(not unsupported and names <= allowed, "Unexpected QCP assumptions")
    need(audit.count("Closed under the global context") == legacy["globally_closed_obligations"],
         "QCP closed-assumption count changed")
    need(audit.count("Axioms:") + audit.count("Closed under the global context") == len(entries),
         "QCP assumption audit omits original obligations")
    models = receipt.get("models", [receipt["model"]])
    need(receipt["model"]["exit_code"] == 0
         and receipt["model"]["candidate_sha256"] == digest(candidate),
         "Final QCP proof is not the metered successful candidate")
    tokens = 0
    for model in models:
        tokens += model_attempt(model, "QCP model attempt")
        folder = receipt_path.parent if model == receipt["model"] else (
            receipt_path.parent / "model-attempts" / ("attempt-" + str(model["attempt"])))
        event_log = folder / "agent.stdout.jsonl"
        need(digest(event_log) == model["raw_event_log_sha256"], "QCP model events changed")
        observed_usage = []
        for line in event_log.read_text(errors="replace").splitlines():
            try:
                event = json.loads(line)
            except ValueError:
                continue
            if event.get("type") == "turn.completed" and isinstance(event.get("usage"), dict):
                observed_usage.append(event["usage"])
        need(observed_usage == model["token_usage"], "QCP token usage differs from actual CLI events")
        need(digest(folder / "prompt.txt") == model["prompt_sha256"], "QCP prompt changed")
        need(model["locked_goal_and_helper_sha256"]["PrimaryQcpGoal.v"] == digest(original),
             "QCP model used a different original goal")
    need(receipt["metrics"]["tokens"] == tokens, "QCP model cost omits attempts")
    return receipt


ITP_STAGES = ("agent", "coq_compile_and_assumption_audit", "independent_kernel_check", "total")


def measured_stage_totals(stages):
    need(stages, "Missing actually measured ITP stage")
    rss = [(stage.get("resources") or {}).get("max_process_rss_kib") for stage in stages]
    known = [value for value in rss if value is not None]
    complete = len(known) == len(rss)
    return {"wall_seconds": sum(stage["wall_seconds"] for stage in stages),
            "peak_process_rss_kib": max(known) if complete else None,
            "observed_peak_rss_lower_bound_kib": max(known) if known else None,
            "resource_metrics_complete": complete, "tokens": 0, "subprocesses": len(stages)}


def execution_metrics(models, checks):
    """Recompute disjoint costs: models once, every checker invocation once."""
    compile_cost = measured_stage_totals([stage for check in checks for stage in check["stages"]
                                         if not stage["stage"].startswith("kernel_replay")])
    kernel_cost = measured_stage_totals([stage for check in checks for stage in check["stages"]
                                        if stage["stage"].startswith("kernel_replay")])
    agent = {"wall_seconds": sum(model["wall_seconds"] for model in models),
             "peak_process_resident_bytes": max(
                 model["resources"]["max_process_peak_working_set_bytes"]
                 if "max_process_peak_working_set_bytes" in model["resources"]
                 else model["resources"]["max_process_rss_kib"] * 1024 for model in models),
             "tokens": sum(model_attempt(model, "ITP model cost") for model in models),
             "model_calls": len(models)}
    complete = compile_cost["resource_metrics_complete"] and kernel_cost["resource_metrics_complete"]
    peaks = [agent["peak_process_resident_bytes"]] + [value["observed_peak_rss_lower_bound_kib"] * 1024
        for value in (compile_cost, kernel_cost) if value["observed_peak_rss_lower_bound_kib"] is not None]
    total = {"wall_seconds": agent["wall_seconds"] + compile_cost["wall_seconds"] + kernel_cost["wall_seconds"],
             "peak_process_resident_bytes": max(peaks) if complete else None,
             "observed_peak_rss_lower_bound_bytes": max(peaks), "resource_metrics_complete": complete,
             "tokens": agent["tokens"], "model_calls": len(models), "check_attempts": len(checks)}
    return dict(zip(ITP_STAGES, (agent, compile_cost, kernel_cost, total)))


def aggregate_metrics(receipts):
    need(receipts, "Missing ITP receipts for cost aggregation")
    result = {"executions": len(receipts),
              "model_calls": sum(receipt["metrics"]["total"]["model_calls"] for receipt in receipts),
              "check_attempts": sum(receipt["metrics"]["total"]["check_attempts"] for receipt in receipts),
              "stages": {}}
    for name in ITP_STAGES:
        values = [receipt["metrics"][name] for receipt in receipts]
        peaks = [value["peak_process_resident_bytes"] if "peak_process_resident_bytes" in value
                 else value["peak_process_rss_kib"] * 1024 if value["peak_process_rss_kib"] is not None
                 else None for value in values]
        seconds, tokens = sum(value["wall_seconds"] for value in values), sum(value["tokens"] for value in values)
        complete = all(value is not None for value in peaks)
        result["stages"][name] = {"wall_seconds_total": seconds, "wall_seconds_mean": seconds / len(values),
            "peak_process_memory_mib_mean": statistics.mean(peaks) / 1048576 if complete else None,
            "peak_process_memory_mib_max": max(peaks) / 1048576 if complete else None,
            "resource_metrics_complete": complete, "tokens_total": tokens, "tokens_mean": tokens / len(values)}
    result["resource_metrics_complete"] = all(receipt["resource_metrics_complete"] for receipt in receipts)
    result["missing_measurements"] = [item for receipt in receipts for item in receipt["missing_measurements"]]
    return result


def corresponding(actual, expected, label):
    """Compare computed fields while permitting separately documented scope text."""
    need(isinstance(actual, dict), "Missing computed statistics: " + label)
    for key, value in expected.items():
        need(key in actual, "Missing computed statistic: " + label + "." + key)
        if isinstance(value, dict):
            corresponding(actual[key], value, label + "." + key)
        else:
            need(actual[key] == value, "Computed statistic differs: " + label + "." + key)


def audit_cost_statistics(root, base, data, table, receipts):
    aggregate = aggregate_metrics(receipts)
    stats_path = base / "tespec/statistics.json"
    stats = load(stats_path)
    corresponding(table.get("itp_statistics"), aggregate, "cost table ITP")
    corresponding(stats.get("itp_statistics"), aggregate, "tespec ITP")
    corresponding(stats, {"tokens": aggregate["stages"]["total"]["tokens_total"],
        "model_calls": aggregate["model_calls"], "itp_required_executions": len(receipts),
        "itp_completed_executions": len(receipts), "executions": len(data["runs"]),
        "case_pairs": data["case_pairs"], "complete": data["complete"],
        "verdict_complete": True, "resource_metrics_complete": aggregate["resource_metrics_complete"],
        "missing_measurements": aggregate["missing_measurements"]}, "tespec statistics")
    expected_costs = []

    def cost(tool, stage, seconds, peak, tokens, source):
        expected_costs.append({"tool": tool, "stage": stage, "wall_seconds": seconds,
            "peak_process_memory_mib": peak, "tokens": tokens, "source": str(source.relative_to(root)),
            "estimated": False, "status": "MEASURED" if peak is not None else "PARTIAL_MISSING_RSS"})

    # Historical rows retain their own named statistics source and measurement units.
    source = base / "cn/statistics.json"
    cn = load(source)
    cost("cn", "主程序验证", cn["wall_seconds"], cn["peak_process_resident_mib"], cn["tokens"], source)
    source = base / "qcp/statistics.json"
    qcp = load(source)
    labels = ("VC 生成与自动处理", "agent 填写证明", "Coq 编译与假设审计", "独立内核检查")
    names = ("vc_generation_and_automatic_processing", "agent_proof_filling",
             "coq_compilation_and_assumption_audit", "independent_kernel_check")
    qcp_stages = {stage["stage"]: stage for stage in qcp["stages"]}
    for name, label in zip(names, labels):
        value = qcp_stages[name]
        cost("qcp", label, value["wall_seconds"], value["peak_process_memory_mib"], value["total_tokens"], source)
    qcp_itp = [qcp_stages[name] for name in names[1:]]
    cost("qcp", "ITP 平均合计", sum(value["wall_seconds"] for value in qcp_itp),
         max(value["peak_process_memory_mib"] for value in qcp_itp),
         sum(value["total_tokens"] for value in qcp_itp), source)
    source = base / "fulminate/statistics.json"
    fulminate = load(source)
    for label, wall, peak in (("插桩、编译与首次执行", "instrument_compile_initial_execution_wall_seconds_total", "pipeline_peak_process_rss_kib"),
                              ("单独运行测试", "test_execution_wall_seconds_total", "test_peak_process_rss_kib")):
        cost("fulminate", label, fulminate[wall], fulminate[peak] / 1024, 0, source)

    modes = {}
    for strategy in ("inline", "modular"):
        for mode in ("off", "on"):
            key = strategy + ":" + mode
            rows = [row for row in data["runs"] if row["strategy"] == strategy and row["spatial_smt"] == mode]
            need(rows, "Missing native cost measurements: " + key)
            proofs = [receipt for receipt in receipts if receipt["strategy"] == strategy and receipt["spatial_smt"] == mode]
            value = {"execution_strategy": strategy, "spatial_smt": mode, "executions": len(rows),
                "native_status_counts": {status: sum(row["raw_status"] == status for row in rows) for status in dict.fromkeys(row["raw_status"] for row in rows)},
                "final_status_counts": {status: sum(row["final_status"] == status for row in rows) for status in dict.fromkeys(row["final_status"] for row in rows)},
                "expected_matches": sum(row["final_status"] == row["expected"] for row in rows),
                "execution_wall_seconds_total": sum(native_cost(row)[0] for row in rows),
                "mean_execution_wall_seconds": statistics.mean(native_cost(row)[0] for row in rows),
                "mean_execution_peak_rss_mib": statistics.mean(native_cost(row)[1] for row in rows) / 1024,
                "maximum_execution_peak_rss_mib": max(native_cost(row)[1] for row in rows) / 1024,
                "native_tokens": 0, "native_model_calls": 0,
                "completed_independent_itp_executions": len(proofs), "pending_independent_itp_executions": 0,
                "itp": aggregate_metrics(proofs) if proofs else {"status": "NOT_REQUIRED", "executions": 0}}
            modes[key] = value
            cost("tespec " + key.replace(":", " spatial-"), "原生测试执行与自动处理",
                 value["mean_execution_wall_seconds"], value["mean_execution_peak_rss_mib"], 0,
                 path_in(root, table["canonical_evaluation"]["path"]))
    corresponding(stats.get("modes"), modes, "tespec modes")
    corresponding(table.get("test_modes", {}).get("modes"), modes, "cost table modes")
    need(table.get("test_modes", {}).get("statistics") == str(stats_path.relative_to(root)), "Wrong mode statistics source")
    for name, label in zip(ITP_STAGES, ("agent 填写证明", "Coq 编译与假设审计", "独立内核检查", "ITP 平均合计")):
        value = aggregate["stages"][name]
        cost("tespec inline ITP", label, value["wall_seconds_mean"],
             value["peak_process_memory_mib_mean"], value["tokens_mean"], stats_path)
    need(len(table["costs"]) == len(expected_costs), "Unexpected/missing current cost rows")
    for actual, expected in zip(table["costs"], expected_costs):
        corresponding(actual, expected, "source-bound cost row")


def audit_itp(root, receipt_ref, row, allow_partial=False, evidence_reader=None):
    read_ref = evidence_reader or ref
    receipt = load(read_ref(root, receipt_ref))
    need(receipt.get("schema") == ITP_SCHEMA and receipt.get("status") == "PASS",
         "Missing successful per-execution ITP receipt")
    for key in ("case", "strategy", "spatial_smt", "source_sha256"):
        need(receipt.get(key) == row[key], "ITP execution binding differs: " + key)
    goal = read_ref(root, receipt["goal"])
    candidate = read_ref(root, receipt["candidate"])
    need(digest(goal) == row["vc_sha256"]["goal"] == receipt["original_goal_sha256"],
         "ITP proves a different generated Goal")
    check_candidate_commands(candidate.read_text())
    inventory = dict(goal_interface(goal.read_text()))
    selected = receipt.get("selected_goals")
    need(isinstance(selected, list) and selected and len(selected) == len(set(selected))
         and set(selected) == set(row["residual_vcs"]) and set(selected) <= set(inventory),
         "ITP does not cover every original residual VC")
    for dependency in receipt.get("dependencies", []):
        read_ref(root, dependency)
    imports = re.findall(r"(?m)^Require Import ([A-Za-z_][A-Za-z0-9_.]*)\.", goal.read_text())
    dependencies = {item.get("module", Path(item["path"]).stem) for item in receipt.get("dependencies", [])}
    need(set(imports) <= dependencies, "Original Goal external dependency is not bound")
    proof_files = receipt.get("proof_files", {})
    need({"Coverage.v", "Assumptions.v"} <= set(proof_files), "Missing original proof coverage/audit sources")
    for proof in proof_files.values():
        read_ref(root, proof)
    coverage = read_ref(root, proof_files["Coverage.v"])
    need(coverage.read_text() == coverage_source([(name, inventory[name]) for name in selected], partial=True),
         "Retained coverage omits an original residual goal")
    models = receipt.get("model_attempts")
    need(isinstance(models, list) and models, "ITP missing actual model attempts")
    model_by_hash = {}
    for model in models:
        model_attempt(model, "ITP model attempt")
        model_hash = hash_value(model.get("source_receipt_sha256"), "ITP model receipt")
        need(model_hash not in model_by_hash, "ITP model invocation counted more than once")
        model_by_hash[model_hash] = model
        locked = model.get("locked_goal_and_helper_sha256", {})
        need(locked.get("Goal.v") == digest(goal), "ITP model used another original Goal")
        for dependency in receipt.get("dependencies", []):
            need(locked.get(Path(dependency["path"]).name) == dependency["sha256"],
                 "ITP model dependency differs from checked dependency")
    need(models[-1]["exit_code"] == 0 and models[-1]["candidate_sha256"] == digest(candidate),
         "ITP final candidate not bound to successful metered model")
    checks = receipt.get("checks")
    need(isinstance(checks, list) and checks, "ITP missing compiler/kernel attempts")
    missing = []
    for check in checks:
        model_hash = check.get("model_receipt_sha256")
        need(isinstance(model_hash, str) and model_hash in model_by_hash,
             "ITP check has no unique metered model invocation")
        model = model_by_hash[model_hash]
        need(check.get("candidate_sha256") == model["candidate_sha256"]
             and check.get("model_attempt") == model["attempt"], "ITP checker/model candidate binding differs")
        hash_value(check.get("certificate_report_sha256"), "ITP checker report")
        stages = check.get("stages")
        need(isinstance(stages, list) and stages, "ITP check missing measured stages")
        for stage in stages:
            absent = attempt_measurement(stage, "ITP " + stage["stage"],
                allow_missing_rss=allow_partial and check.get("status") != "PASS")
            if absent:
                missing.append((check["attempt"], stage["stage"], stage["wall_seconds"], stage["exit_code"], stage["log_sha256"]))
            hash_value(stage.get("log_sha256"), "ITP stage log")
    strong = receipt.get("proof_profile") == PROFILE
    need(receipt.get("proof_profile") in (None, PROFILE), "Unsupported proof profile")
    recorded = receipt.get("active_missing_measurements", []) if strong else receipt.get("missing_measurements", [])
    need([(m["check_attempt"], m["stage"], m["wall_seconds"], m["exit_code"], m["log_sha256"]) for m in recorded] == missing,
         "ITP missing RSS inventory differs from actual attempts")
    need(receipt.get("active_resource_metrics_complete" if strong else "resource_metrics_complete") is (not bool(missing)), "ITP cost completeness flag differs")
    for m in recorded:
        need(m.get("field") == "resources.max_process_rss_kib" and m.get("reason"), "Unclassified cost gap")
        for key in ("case", "strategy", "spatial_smt"):
            need(m[key] == row[key], "Cost gap belongs to another execution")
    selected_hash = receipt.get("selected_check_sha256")
    if selected_hash is None:
        final = checks[-1]
    else:
        hash_value(selected_hash, "ITP selected checker receipt")
        selected_checks = [check for check in checks if check.get("controller_receipt_sha256") == selected_hash]
        need(len(selected_checks) == 1, "ITP selected checker receipt is missing or ambiguous")
        final = selected_checks[0]
    need(final["model_receipt_sha256"] == models[-1]["source_receipt_sha256"], "ITP unchecked later model attempt")
    need(final.get("status") == "PASS" and final.get("scope") == "selected-original-vcs",
         "ITP final checker has not proved selected original VCs")
    need(final.get("kernel_replay_mode") == "full", "ITP requires independent full kernel replay")
    need(final.get("original_goal_sha256") == digest(goal)
         and final.get("candidate_sha256") == digest(candidate)
         and set(final.get("selected_goals", [])) == set(selected), "ITP final check evidence mismatch")
    need(final.get("assumptions_audited_goals") == len(selected)
         and final.get("unsupported_assumption_records") == []
         and final.get("unexpected_assumptions") == [], "ITP assumption audit incomplete")
    audit = final.get("audit_text")
    need(isinstance(audit, str) and hashlib.sha256(audit.encode()).hexdigest() == final.get("audit_sha256"),
         "ITP assumption text hash mismatch")
    names, unsupported = assumption_audit_from_output(audit)
    need(not unsupported and names <= TRUSTED_ASSUMPTIONS and set(final.get("assumptions", [])) == names,
         "Unapproved ITP assumptions")
    need(audit.count("Axioms:") + audit.count("Closed under the global context") == len(selected),
         "ITP printed audit omits original goals")
    if names:
        need("AssumptionIdentities.v" in proof_files, "Missing allowed-assumption identity source")
        need(final.get("assumption_identities") == [ASSUMPTION_IDENTITIES[name] for name in sorted(names)],
             "ITP allowed assumption identities were not checked")
    stages = final["stages"]
    required = {"version", "compile_Goal.v", "compile_Candidate.v", "compile_Coverage.v",
                "compile_Assumptions.v", "kernel_replay"}
    if strong:
        required.update("compile_dependencies_" + d["module"] + ".v" for d in receipt["dependencies"])
    if names:
        required.add("assumption_identities")
    need(required <= {stage["stage"] for stage in stages}, "Incomplete ITP compile/kernel stages")
    need(all(stage["exit_code"] == 0 for stage in stages), "Failed final ITP stage")
    audit_stage = next(stage for stage in stages if stage["stage"] == "compile_Assumptions.v")
    need(audit_stage["log_sha256"] == final["audit_sha256"], "ITP audit not from checked compilation")
    actual_metrics = execution_metrics(models, checks)
    if strong:
        audit_strong_binding(root, receipt, row, final, evidence_reader=read_ref)
        need(receipt.get("active_metrics") == actual_metrics, "Strong active-context costs differ")
        old_metrics, old_missing = legacy_costs(root, receipt.get("legacy_cost_receipts"), row)
        need(receipt.get("legacy_metrics", []) == old_metrics, "Strong legacy-context costs differ")
        actual_metrics = combine_metrics(old_metrics + [actual_metrics])
        active_missing = [{**m, "proof_context": "active"} for m in recorded]
        need(receipt.get("missing_measurements") == old_missing + active_missing, "Strong publication dropped a historical cost gap")
        need(receipt.get("resource_metrics_complete") is (not bool(old_missing + active_missing)), "Strong cumulative cost completeness differs")
        need(allow_partial or receipt["resource_metrics_complete"], "Legacy cost gap requires explicit partial audit")
    need(receipt.get("metrics") == actual_metrics, "ITP measured attempt costs differ")
    return receipt


def audit_canonical_group(group, root=ROOT, index=None, allow_partial=False):
    root = root.resolve()
    base = root / "benchmark/results" / group
    index = load(base / "index.json") if index is None else index
    data = load(ref(root, index["canonical_evaluation"]))
    need(data.get("schema") == SCHEMA and data.get("group", data.get("program_group")) == group,
         "Wrong canonical evaluation schema/group")
    if group == "Dbl_Linked_List__singleton":
        need(data.get("proof_profile") == PROFILE, "Singleton completion requires explicit ABI strong-left evidence; parent-only legacy receipts are costs only")
    need(data.get("verdict_complete") is True, "Canonical verdicts incomplete")
    complete = data.get("resource_metrics_complete") is True
    need(data.get("complete") is complete and index.get("complete") is complete, "Canonical completeness flags disagree")
    need(complete or allow_partial, "Canonical costs incomplete; use explicit --allow-partial to audit published gaps")
    need(complete or data.get("missing_measurements"), "Partial publication does not identify missing costs")
    plan_path = root / "benchmark/programs" / group / "evaluation-plan.json"
    need(digest(plan_path) == data.get("plan_sha256"), "Evaluation plan changed")
    plan = load(plan_path)
    manifest = load(plan_path.parent / "manifest.json")
    source_hashes = {}
    variants = {}
    for item in manifest["variants"]:
        variant = load(path_in(root, item["manifest"]))
        variants[variant["id"]] = variant
        for file in variant["files"].values():
            source = ref(root, file)
            source_hashes[str(source.relative_to(root))] = file["sha256"]
    refs = {str(ref(root, item).relative_to(root)): item["sha256"] for item in data["source_refs"]}
    need(all(refs.get(path) == value for path, value in source_hashes.items()),
         "Canonical evidence does not bind every variant source")
    transition_map = {}
    if data.get("proof_profile") is not None:
        need(group == "Dbl_Linked_List__singleton" and data["proof_profile"] == PROFILE, "Wrong group proof profile")
        transition, transition_map = audit_transition(root, data["context_transition"], data["runs"], data["original_native_results_sha256"], data["abi_context"])
        review = load(ref(root, data["semantic_review"]))
        need(review.get("status") == "RESOLVED_FOR_EXPLICIT_ABI_CONTEXT" and review.get("resolution_native_results_sha256") == data["original_native_results_sha256"], "Strong semantic review is not resolved for this native run")
        need(review.get("legacy_review_snapshot") == transition["semantic_review"], "Resolved review lacks frozen legacy audit reference")
        need(review.get("resolution_abi_context_sha256") == canonical_sha(data["abi_context"]) and review.get("legacy_context_status") == "NOT_CERTIFIED", "Strong resolution context differs")
    cases = {}
    for pair in plan["pairings"]:
        for case in pair["cases"]:
            key = (pair["cn_variant"], case["id"])
            need(key not in cases and case.get("precondition_valid") is True, "Invalid/duplicate planned input")
            cases[key] = (case, pair)
    need({v for _, pair in cases.values() for v in (pair["cn_variant"], pair["qcp_variant"])} == set(variants),
         "Evaluation plan omits variant records")
    expected_keys = {(vid, cid, strategy, mode) for vid, cid in cases
                     for strategy in ("inline", "modular") for mode in ("off", "on")}
    seen = set()
    agent_events = set()
    checker_reports = set()
    itp_count = 0
    itp_receipts = []
    missing_costs = []
    for row_index, row in enumerate(data["runs"]):
        source = path_in(root, row["source"])
        matches = [(key, case, pair) for key, (case, pair) in cases.items()
                   if key[1] == row["case"] and variants[pair["qcp_variant"]]["files"]["qcp"]["path"]
                   == str(source.relative_to(root))]
        need(len(matches) == 1, "Ambiguous/unplanned native input")
        (vid, cid), case, pair = matches[0]
        key = (vid, cid, row["strategy"], row["spatial_smt"])
        need(key in expected_keys and key not in seen, "Duplicate/unexpected execution configuration")
        seen.add(key)
        need(row["input"] == case["binds"], "Native input changed")
        expected = case.get("expected_by_tool", {}).get("tespec_" + row["spatial_smt"], case["expected"])
        expected = case.get("expected_by_execution_strategy", {}).get(row["strategy"], expected)
        need(row["expected"] == row["final_status"] == expected, "Unresolved execution mismatch")
        need(row.get("precondition_result") == "SAT" and row.get("execution_completed") is True,
             "Execution did not reach an auditable exit from a legal input")
        need(row["source_sha256"] == digest(source), "Execution source changed")
        number(row.get("wall_seconds"), "native time")
        number((row.get("resources") or {}).get("max_process_rss_kib"), "native RSS", True)
        hash_value(row["vc_sha256"]["goal"], "native original Goal")
        if transition_map:
            mapping = transition_map[row_index]
            need(row.get("native_attempts") == [mapping["legacy_native_stage"], mapping["active_native_stage"]] and row.get("context_transition_execution_key") == mapping["execution_key"], "Native costs omit or repeat a context attempt")
        else:
            need(not row.get("native_attempts"), "Native context costs have no audited transition")
        if row["raw_status"] == "UNKNOWN":
            need(row["final_status"] == "PASS", "Canonical v1 only accepts positive ITP writeback")
            receipt = audit_itp(root, row["itp_receipt"], row, allow_partial=allow_partial)
            if transition_map:
                need(receipt.get("proof_profile") == PROFILE and receipt.get("abi_context") == data["abi_context"], "Legacy parent proof cannot authorize strong-context writeback")
                original_manifest = load(ref(root, receipt["original_manifest"]))
                runtime_deps = sorted(({k: d[k] for k in ("module", "sha256", "compiled_sha256")} for d in original_manifest["runtime_dependencies"]), key=lambda d: d["module"])
                need(runtime_deps == transition["active_context"]["runtime_dependencies"], "Strong receipt native runtime differs from transition context")
                legacy = mapping["legacy_itp_receipt"]
                need(receipt["legacy_cost_receipts"] == ([legacy] if legacy else []), "Execution drops/repeats required legacy ITP cost")
                need(receipt["execution_index"] == mapping["active_itp_execution_index"] and row["itp_receipt"]["path"] == mapping["active_itp_receipt_path"], "Strong receipt does not follow transition execution mapping")
            else:
                need(not receipt.get("proof_profile"), "Strong receipt lacks audited group context")
            itp_receipts.append(receipt)
            missing_costs.extend(receipt.get("missing_measurements", []))
            itp_count += 1
            for check in receipt["checks"]:
                report_hash = check["certificate_report_sha256"]
                need(report_hash not in checker_reports, "One kernel/check attempt counted for two executions")
                checker_reports.add(report_hash)
            for model in receipt["model_attempts"]:
                event = model["raw_event_log_sha256"]
                need(event not in agent_events, "One model invocation reused as two execution measurements")
                agent_events.add(event)
        else:
            need(row["raw_status"] == row["final_status"], "Native result changed without ITP")
            need(not row.get("itp_receipt"), "Unnecessary/unclassified ITP receipt")
            if row["final_status"] == "PASS":
                need(row.get("residual_vcs") == [], "Native PASS still has residual obligations")
    need(seen == expected_keys, "Incomplete inline/modular OFF/ON input coverage")
    need(data.get("itp_executions") == itp_count and data.get("pending_itp_executions") == 0,
         "Group ITP execution counts differ from checked receipts")
    if group == "Dbl_Linked_List__singleton":
        need(itp_count == 14, "Singleton requires 14 independent checked ITP executions")
    need(missing_costs == data.get("missing_measurements", []), "Group cost gap inventory differs from attempt receipts")
    need(complete is (not bool(missing_costs)), "Group hides missing attempt costs")
    tools = {name: load(ref(root, data["tool_evidence"][name])) for name in ("cn", "fulminate", "qcp")}
    for tool, publication in tools.items():
        expected = path_in(root, publication["receipt" if tool == "qcp" else "evidence"])
        need(ref(root, data["tool_receipt_refs"][tool]) == expected, "Historical raw receipt is not bound")
        need(ref(root, data["tool_statistics_refs"][tool]) == base / tool / "statistics.json",
             "Historical tool cost statistics are not bound")
    cn = audit_cn(root, tools["cn"], group, source_hashes, plan["function"])
    fulminate = audit_fulminate(root, tools["fulminate"], cases)
    qcp = audit_qcp(root, tools["qcp"], source_hashes)
    log_refs = {str(ref(root, item).relative_to(root)) for item in data["tool_log_refs"]}
    measured = [cn.get("cn", cn)] + [m for run in fulminate["runs"] for m in (run["pipeline"], run["test"])]
    measured += qcp["compilation"] + [qcp["kernel_check"]]
    need({m[stream] for m in measured for stream in ("stdout", "stderr")} <= log_refs,
         "Historical raw tool logs lack canonical hash bindings")
    table = load(base / "result-cost.json")
    need(table.get("complete") is complete and table.get("resource_metrics_complete") is complete, "Group cost completeness differs")
    need(table.get("missing_measurements", []) == missing_costs, "Cost table gaps differ from receipts")
    audit_cost_statistics(root, base, data, table, itp_receipts)
    need({row["tool"] for row in table["results"]} >= {"cn", "qcp", "fulminate", "tespec"},
         "Missing tool in group result table")
    for cost in table["costs"]:
        if cost.get("historical") or cost.get("required") is False:
            continue
        need(cost.get("status") not in {"PENDING", "BLOCKED"}, "A required cost remains pending")
        number(cost.get("wall_seconds"), "table time")
        if cost.get("peak_process_memory_mib") is None:
            need(allow_partial and not complete and cost.get("status") == "PARTIAL_MISSING_RSS",
                 "Unexplained missing cost-table RSS")
        else:
            number(cost["peak_process_memory_mib"], "table memory")
        number(cost.get("tokens"), "table tokens")
    need((base / "result-cost.md").stat().st_size > 0, "Missing human result table")
    with (base / "result-cost.csv").open(newline="") as stream:
        cost_rows = list(csv.DictReader(stream))
    need(len(cost_rows) == len(table["costs"]), "CSV/JSON cost row count mismatch")
    for machine, display in zip(table["costs"], cost_rows):
        for key in ("tool", "stage"):
            need(str(machine[key]) == display[key], "CSV/JSON cost identity mismatch")
        for key in ("wall_seconds", "peak_process_memory_mib", "tokens"):
            need((machine.get(key) is None and display.get(key) in ("", "None"))
                 or (machine.get(key) is not None and float(display[key]) == machine[key]),
                 "CSV/JSON cost value mismatch: " + key)
    label = "PASS" if complete else "PARTIAL (verdicts checked; incomplete RSS)"
    print(f"{label} {group}: {len(cases)} inputs, {len(seen)} strategy/mode decisions, "
          f"{itp_count} independent complete ITP tasks, exact source/proof bindings and measured costs.")
    return data
