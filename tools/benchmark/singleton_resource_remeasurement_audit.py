#!/usr/bin/env python3
"""Strict audit of a new, explicitly selected whole-check measurement cohort.

Original proofs, failed measurements and all-incurred costs remain immutable.
This module never executes a prover, repairs evidence or upgrades a verdict.
"""
from __future__ import annotations
import copy
import hashlib
import io
import json
import math
from pathlib import Path

SCHEMA = "whole-check-remeasurement/v1"
GROUP = "Dbl_Linked_List__singleton"
BASE = "benchmark/results/" + GROUP
EXPECTED_REPLACEMENTS = {(0, "legacy", "attempt-2"), (0, "legacy", "attempt-3"),
                         (3, "active", "attempt-1-infrastructure-interruption")}


def need(value, message):
    if not value:
        raise ValueError(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def canonical(value):
    from singleton_canonical_support import canonical_sha
    return canonical_sha(value)


def same(actual, expected, label):
    """Only permit harmless floating-point summation rounding, never missing keys."""
    if isinstance(expected, dict):
        need(isinstance(actual, dict), "Missing " + label)
        for key, value in expected.items():
            need(key in actual, "Missing " + label + "." + key)
            same(actual[key], value, label + "." + key)
    elif isinstance(expected, list):
        need(isinstance(actual, list) and len(actual) == len(expected), "Different " + label)
        for i, value in enumerate(expected):
            same(actual[i], value, label + "." + str(i))
    elif type(expected) is float:
        need(type(actual) in (int, float) and math.isfinite(actual) and
             abs(actual - expected) <= 1e-8, "Different " + label)
    else:
        need(actual == expected and (type(actual) is type(expected) or
             (type(actual) in (int, float) and type(expected) in (int, float))), "Different " + label)


def _reader(root, evidence_reader=None):
    import validate_canonical_group as v
    return evidence_reader or v.ref


def _load(root, reference, read):
    return json.loads(read(root, reference).read_text())


def baseline_view(root, profile, evidence_reader=None):
    """Recover exact historical summary bytes in a read-only path overlay."""
    import validate_canonical_group as v
    read = _reader(root, evidence_reader)
    snapshot = _load(root, profile["baseline_snapshot"], read)
    need(snapshot.get("schema") == "singleton-cost-baseline/v1", "Wrong baseline capsule")
    inventory = profile["baseline_publications"]
    need(isinstance(inventory, list), "Missing baseline inventory")
    documents, overlays = snapshot["documents"], {}
    need(len(inventory) == len(documents) and {x["target_path"] for x in inventory} == set(documents),
         "Baseline capsule inventory differs")
    required = {BASE + "/" + name for name in ("index.json", "evidence/tespec-native.json",
        "result-cost.json", "result-cost.csv", "result-cost.md", "tespec/statistics.json",
        "tespec/results.json", "coverage-gap.json")}
    need(required <= set(documents), "Incomplete baseline summary capsule")
    allowed = required | {"benchmark/programs/" + GROUP + "/manifest.json"}
    need(set(documents) <= allowed, "Baseline capsule must contain summaries only")
    for item in inventory:
        target = item["target_path"]
        value = documents[target]
        need(isinstance(value.get("text"), str), "Baseline document has no exact UTF-8 bytes")
        raw = value["text"].encode("utf-8")
        need(sha(raw) == value["sha256"] == item["sha256"], "Baseline document hash differs: " + target)
        path = (root / target).resolve()
        need(path.is_relative_to(root.resolve()), "Baseline path escapes repository")
        overlays[Path(path)] = raw
    pinned = profile["baseline_evaluation"]
    need(pinned["target_path"] == BASE + "/evidence/tespec-native.json" and
         pinned["sha256"] == documents[pinned["target_path"]]["sha256"], "Baseline evaluation is not pinned")
    parent_type = type(root)
    class BaselinePath(parent_type):
        def read_bytes(self):
            path = Path(self).resolve()
            return overlays[path] if path in overlays else super().read_bytes()
        def read_text(self, encoding=None, errors=None):
            return self.read_bytes().decode(encoding or "utf-8", errors or "strict")
        def open(self, mode="r", buffering=-1, encoding=None, errors=None, newline=None):
            if Path(self).resolve() in overlays:
                need(mode in ("r", "rt", "rb"), "Baseline overlay is read-only")
                return io.BytesIO(self.read_bytes()) if "b" in mode else io.StringIO(self.read_text(encoding, errors), newline=newline)
            return super().open(mode, buffering, encoding, errors, newline)
        def stat(self, *args, **kwargs):
            if Path(self).resolve() in overlays:
                from types import SimpleNamespace
                return SimpleNamespace(st_size=len(self.read_bytes()), st_mode=0o100444)
            return super().stat(*args, **kwargs)
    overlay = BaselinePath(root)
    index = json.loads(overlays[Path(root / BASE / "index.json")])
    need(not index.get("measurement_profile"), "Baseline must precede the new measurement profile")
    baseline = v.audit_canonical_group(GROUP, overlay, index, allow_partial=True)
    need(baseline["verdict_complete"] is True and baseline["complete"] is False and
         len(baseline["missing_measurements"]) == 9, "Unexpected historical baseline")
    return baseline, overlay


def _resource_record(stage, records):
    import validate_canonical_group as v
    digest = stage.get("resource_sha256")
    need(digest in records and sha(records[digest].encode()) == digest, "Missing original GNU time record")
    text = records[digest]
    parsed = None
    for line in reversed(text.splitlines()):
        try:
            value = json.loads(line)
        except (ValueError, TypeError):
            continue
        if isinstance(value, dict) and "max_process_rss_kib" in value:
            parsed = value
            break
    need(parsed is not None, "GNU time record has no measured resources")
    resources = stage.get("resources")
    need(isinstance(resources, dict), "Remeasured stage lacks resources")
    for key in ("elapsed_seconds", "user_seconds", "system_seconds", "max_process_rss_kib"):
        v.number(parsed.get(key), "GNU time " + key)
        need(resources.get(key) == parsed[key], "Remeasured stage/resource file differs: " + key)
    v.number(stage.get("wall_seconds"), "Remeasured stage wall time")
    need(type(stage.get("exit_code")) is int, "Remeasurement did not close with measured exit status")
    v.hash_value(stage.get("log_sha256"), "Remeasured stage log hash")


def audit_replay(root, replacement, source, original, plan, records, read):
    """Bind a new complete checker measurement to exact old inputs and commands."""
    import validate_canonical_group as v
    raw = _load(root, replacement["new_replay"], read)
    need(raw.get("schema") == "tespec-singleton-resource-remeasurement/v1" and
         raw.get("profile") == SCHEMA and raw.get("status") in ("KERNEL_CHECKED", "UNKNOWN"), "Unclosed replay receipt")
    need(raw.get("model_calls") == raw.get("tokens") == 0 and raw.get("verdict_authority") is False and
         raw.get("kernel_cache") is None, "Replay cannot create model usage or proof authority")
    key = (replacement["execution_index"], replacement["proof_context"], replacement["original_check_attempt"])
    jobs = [job for job in plan["jobs"] if (job["execution_index"], job["proof_context"], job["original_check_attempt"]) == key]
    need(len(jobs) == 1, "Replay job is absent or duplicated in the frozen plan")
    job = jobs[0]
    for name, value in job.items():
        need(raw.get(name) == value, "Replay changed planned field: " + name)
    need(raw["plan"]["sha256"] == plan["_recorded_sha256"], "Replay plan differs")
    for field in ("runner", "production_checker"):
        need(raw[field] == plan[field], "Replay tool identity differs: " + field)
        reference = {"path": str(Path(plan[field]["path"]).relative_to(Path(root))), "sha256": plan[field]["sha256"]}
        read(root, reference)
    need(job["source_execution"]["sha256"] == replacement["original_receipt"]["sha256"] and
         Path(job["source_execution"]["path"]).resolve() == (Path(root) / replacement["original_receipt"]["path"]).resolve() and
         job["original_check_sha256"] == canonical(original) == replacement["original_check_sha256"] and
         job["original_controller_receipt_sha256"] == original["controller_receipt_sha256"] == replacement["original_controller_receipt_sha256"],
         "Replay does not replace the exact original check")
    need(raw["original_goal_sha256"] == source["original_goal_sha256"] and
         raw["original_candidate_sha256"] == original["candidate_sha256"], "Replay changes Goal or Candidate")
    models = [m for m in source["model_attempts"] if m["source_receipt_sha256"] == original["model_receipt_sha256"]]
    need(len(models) == 1 and raw["source_model_receipt_sha256"] == models[0]["source_receipt_sha256"] and
         models[0]["candidate_sha256"] == raw["original_candidate_sha256"], "Replay changes original model/candidate binding")
    context = replacement["proof_context"]
    command_attempt = original["attempt"] if context == "legacy" else "attempt-1-replay-1"
    commands = [c for c in source["checks"] if c["attempt"] == command_attempt]
    need(len(commands) == 1 and job["command_source_attempt"] == command_attempt and
         job["command_source_check_sha256"] == canonical(commands[0]), "Replay command provenance differs")
    expected_commands = [{"stage": s["stage"], "command": s["command"]} for s in commands[0]["stages"]]
    need(raw["original_commands"] == expected_commands, "Replay changes original command inventory")
    need(raw["kernel_timeout_seconds"] == (300 if context == "legacy" else 1800) and
         raw["compile_timeout_seconds"] == 90 and raw["version_timeout_seconds"] == 15 and
         raw["kernel_silent"] is (context == "active"), "Replay changes declared checker budget/verbosity")
    artifacts = replacement["input_artifacts"]
    need(len({x["name"] for x in artifacts}) == len(artifacts), "Duplicate replay source artifact")
    inputs = {x["name"]: read(root, x["evidence"]) for x in artifacts}
    need(set(inputs) == set(job["files"]) | {"manifest.json"}, "Incomplete replay source inventory")
    for name, reference in job["files"].items():
        need(sha(inputs[name].read_bytes()) == reference["sha256"], "Replay source artifact differs: " + name)
    manifest = json.loads(inputs["manifest.json"].read_text())
    need(sha(inputs["manifest.json"].read_bytes()) == raw["certificate_manifest_sha256"], "Replay manifest differs")
    expected_manifest = original.get("manifest_sha256") if context == "legacy" else source["certificate_manifest"]["sha256"]
    need(raw["certificate_manifest_sha256"] == expected_manifest and
         manifest["runtime_sha256"] == raw["runtime_sha256"] == plan["runtime_sha256"], "Replay manifest/runtime identity differs")
    need(manifest["original_goal_sha256"] == source["original_goal_sha256"] and
         manifest["selected_goals"] == sorted(source["selected_goals"]), "Replay changes original goal coverage")
    expected_files = {"Goal.v": source["goal"]["sha256"], "Candidate.v": original["candidate_sha256"],
                      **{name: ref["sha256"] for name, ref in source["proof_files"].items()},
                      **{"dependencies/" + d["module"] + ".v": d["sha256"] for d in source["dependencies"]}}
    need({name: ref["sha256"] for name, ref in job["files"].items()} == expected_files, "Replay changes proof dependency bytes")
    report = raw["certificate_result"]
    report_bytes = (json.dumps(report, ensure_ascii=False, indent=2) + "\n").encode()
    need(sha(report_bytes) == raw["certificate_report"]["sha256"], "Replay certificate report bytes differ")
    need(raw["status"] == ("KERNEL_CHECKED" if report["status"] == "PASS" else "UNKNOWN") and
         report.get("kernel_replay_mode") == "full", "Replay status or full-kernel mode differs")
    need(report.get("original_goal_sha256") == source["original_goal_sha256"] and
         report.get("candidate_sha256") == original["candidate_sha256"] and
         report.get("manifest_sha256") == raw["certificate_manifest_sha256"] and
         report.get("scope") == "selected-original-vcs", "Replay report changes proof inputs/scope")
    stages, wrappers = raw["stages"], raw["executed_wrappers"]
    need(len(stages) == len(wrappers) == len(expected_commands) == len(report["stages"]), "Replay omits a whole-check stage")
    need(stages[-1]["stage"] == "kernel_replay" and len({s["stage"] for s in stages}) == len(stages), "Replay kernel inventory differs")
    new_work = str(Path(raw["receipt"]).parent / "check")
    for stage, wrapper, old_command, measured in zip(stages, wrappers, expected_commands, report["stages"]):
        name = old_command["stage"]
        need(stage["stage"] == wrapper["stage"] == measured["stage"] == name, "Replay stage order differs")
        for field, value in measured.items():
            if field != "command":
                need(stage.get(field) == value, "Replay stage/report mismatch: " + field)
        actual = [arg.replace(raw["original_work_dir"], new_work) for arg in old_command["command"]]
        need(stage["command"] == wrapper["actual_command"] == actual and
             stage["original_command"] == wrapper["original_command"] == old_command["command"], "Replay command changed beyond workdir relocation")
        production = list(actual)
        if name == "kernel_replay" and context == "active":
            production.remove("-silent")
        need(stage["production_command"] == wrapper["production_command"] == measured["command"] == production,
             "Replay production command differs")
        timeout = raw["kernel_timeout_seconds"] if name == "kernel_replay" else (15 if name == "version" else 90)
        envelope = stage["executed_wrapper_command"]
        need(envelope == wrapper["executed_wrapper_command"] and envelope[:2] == ["/usr/bin/time", "--quiet"] and
             stage["timeout_seconds"] == wrapper["timeout_seconds"] == timeout, "Replay timing wrapper differs")
        split = envelope.index("-o") + 2
        need(envelope[2:split] == ["-f", '{"elapsed_seconds":%e,"user_seconds":%U,"system_seconds":%S,"max_process_rss_kib":%M}', "-o", stage["resource_file"]], "GNU time output format differs")
        need(envelope[split:] == ["/usr/bin/timeout", "--signal=TERM", "--kill-after=5", str(timeout), *actual] and
             envelope[split-1] == stage["resource_file"] == wrapper["resource_file"], "GNU time must enclose timeout and the full measured command")
        _resource_record(stage, records)
        if name == "kernel_replay":
            need("coqchk" in actual and actual[-1] == "Coverage" and
                 "-norec" not in actual and "-admit" not in actual, "Replay reduced kernel dependency closure")
        else:
            need(stage["exit_code"] == 0, "Replay failed before completing all checker stages")
    for key, selected in (("compilation_and_assumption_audit", stages[:-1]), ("independent_kernel_check", stages[-1:]), ("whole_check", stages)):
        same(raw[key], {"wall_seconds": sum(s["wall_seconds"] for s in selected),
            "peak_process_rss_kib": max(s["resources"]["max_process_rss_kib"] for s in selected),
            "subprocesses": len(selected), "resources_complete": True, "tokens": 0}, "replay " + key)
    return {"schema": report["schema"], "stages": stages, "attempt": raw["id"],
            "controller_receipt_sha256": replacement["new_replay"]["sha256"]}


def audit_resource_remeasurement(root, profile, evaluation, evidence_reader=None):
    """Return independently rebuilt current/all-incurred metrics after full audit."""
    import validate_canonical_group as v
    from singleton_canonical_support import group_workload
    read = _reader(root, evidence_reader)
    need(profile.get("schema") == SCHEMA, "Wrong measurement profile")
    baseline, base_root = baseline_view(root, profile, evidence_reader)
    invariant_fields = ("schema", "group", "proof_profile", "repository_commit", "plan_sha256", "source_refs",
        "input_identity", "input_evidence_unchanged", "original_native_results_sha256", "task_inventory_sha256",
        "tool_evidence", "tool_receipt_refs", "tool_statistics_refs", "tool_log_refs", "case_pairs",
        "native_executions", "itp_executions", "pending_itp_executions", "raw_status_counts", "final_status_counts",
        "runs", "abi_context", "semantic_review", "context_transition", "group_shared_setup", "task_overrides", "original_task_inventory")
    for name in invariant_fields:
        need(evaluation.get(name) == baseline.get(name), "Measurement profile changed proof/input scope: " + name)
    need(evaluation.get("verdict_complete") is True and evaluation.get("complete") is True and
         evaluation.get("resource_metrics_complete") is True and
         evaluation.get("current_resource_metrics_complete") is True and
         evaluation.get("historical_cumulative_resource_metrics_complete") is False,
         "Measurement cohort completeness flags differ")
    need(evaluation.get("missing_measurements") == [] and
         profile.get("current_resource_metrics_complete") is True and
         profile.get("historical_cumulative_resource_metrics_complete") is False and
         profile.get("current_missing_measurements") == [] and
         profile.get("historical_missing_measurements") == baseline["missing_measurements"],
         "New cohort must not erase the historical nine missing fields")
    plan = _load(root, profile["runner_plan"], read)
    need(plan.get("schema") == "tespec-singleton-resource-remeasurement-plan/v1" and
         plan.get("profile") == SCHEMA and plan.get("group") == GROUP and
         plan.get("model_calls") == plan.get("tokens") == 0 and plan.get("verdict_authority") is False and
         plan.get("kernel_cache") is None and len(plan["jobs"]) == 3, "Wrong measured replay plan")
    plan["_recorded_sha256"] = profile["runner_plan"]["sha256"]
    resources = _load(root, profile["measurement_artifacts"], read)
    need(resources.get("schema") == "singleton-remeasurement-resources/v1", "Wrong GNU time capsule")
    records = resources["records"]
    for key, value in records.items():
        need(isinstance(value, str) and sha(value.encode()) == key, "Measured resource bytes differ")
    current_receipts, contexts = {}, {}
    for row in baseline["runs"]:
        if not row.get("itp_receipt"):
            continue
        receipt = _load(root, row["itp_receipt"], read)
        index = receipt["execution_index"]
        need(index not in current_receipts, "Repeated independent ITP execution")
        current_receipts[index] = receipt
        contexts[index] = [("legacy", reference, _load(root, reference, read)) for reference in receipt["legacy_cost_receipts"]]
        contexts[index].append(("active", row["itp_receipt"], receipt))
    need(set(current_receipts) == set(range(14)), "Current profile changes the ITP denominator")
    replacements = profile["replacements"]
    keys = [(x["execution_index"], x["proof_context"], x["original_check_attempt"]) for x in replacements]
    need(len(keys) == len(set(keys)) == 3 and set(keys) == EXPECTED_REPLACEMENTS, "Wrong whole-check replacement inventory")
    replacements_by_hash, replay_hashes, covered = {}, set(), []
    for replacement in replacements:
        index, context, attempt = replacement["execution_index"], replacement["proof_context"], replacement["original_check_attempt"]
        sources = [(ref, value) for kind, ref, value in contexts[index] if kind == context and ref == replacement["original_receipt"]]
        need(len(sources) == 1, "Replacement does not name the original frozen context receipt")
        source = sources[0][1]
        matches = [check for check in source["checks"] if check["attempt"] == attempt]
        need(len(matches) == 1, "Replacement original check missing/ambiguous")
        original = matches[0]
        gaps = [g for g in baseline["missing_measurements"] if g["execution_index"] == index and
                g["proof_context"] == context and g["check_attempt"] == attempt]
        expected_keys = [{"stage": g["stage"], "field": g["field"]} for g in gaps]
        need(replacement["gap_keys"] == expected_keys and gaps, "Replacement gap coverage differs")
        covered.extend(gaps)
        replay_hash = replacement["new_replay"]["sha256"]
        need(replay_hash not in replay_hashes, "One replay measurement reused for two old attempts")
        replay_hashes.add(replay_hash)
        replacement_check = audit_replay(root, replacement, source, original, plan, records, read)
        replacements_by_hash[original["controller_receipt_sha256"]] = replacement_check
    need(len(covered) == 9 and {canonical(g) for g in covered} == {canonical(g) for g in baseline["missing_measurements"]},
         "Replays do not cover exactly the original missing fields")
    current_rows, all_rows, executions = [], [], []
    original_count = 0
    for index in range(14):
        # Preserve original model calls once. Legacy attempts precede active ones.
        models = [m for _kind, _ref, receipt in contexts[index] for m in receipt["model_attempts"]]
        checks = [c for _kind, _ref, receipt in contexts[index] for c in receipt["checks"]]
        need(len({m["source_receipt_sha256"] for m in models}) == len(models), "Duplicated model billing")
        original_count += len(checks)
        selected = [replacements_by_hash.get(c["controller_receipt_sha256"], c) for c in checks]
        added = [replacements_by_hash[c["controller_receipt_sha256"]] for c in checks
                 if c["controller_receipt_sha256"] in replacements_by_hash]
        current = v.execution_metrics(models, selected)
        all_incurred = v.execution_metrics(models, checks + added)
        need(current["total"]["resource_metrics_complete"] is True and current["total"]["wall_seconds"] is not None,
             "Selected complete-check cohort still has missing resources")
        historical_gaps = [g for g in baseline["missing_measurements"] if g["execution_index"] == index]
        current_rows.append({**current_receipts[index], "metrics": current, "resource_metrics_complete": True, "missing_measurements": []})
        all_rows.append({**current_receipts[index], "metrics": all_incurred,
                        "resource_metrics_complete": not historical_gaps, "missing_measurements": historical_gaps})
        executions.append({"execution_index": index, "current_metrics": current, "all_incurred_metrics": all_incurred})
    aggregate_current, aggregate_all = v.aggregate_metrics(current_rows), v.aggregate_metrics(all_rows)
    same(profile["per_execution"], executions, "remeasured executions")
    same(profile["metrics"]["current"], aggregate_current, "current cohort statistics")
    same(profile["metrics"]["all_incurred"], aggregate_all, "all-incurred statistics")
    need(original_count == aggregate_current["check_attempts"] == 26 and aggregate_all["check_attempts"] == 29,
         "New replay checks were omitted or counted twice")
    counters = {"case_pairs": 7, "native_executions": 28, "itp_executions": 14, "model_calls": 23,
                "tokens": 2215390, "original_checks": 26, "current_checks": 26, "new_checks": 3, "all_incurred_checks": 29}
    same(profile["counters"], counters, "measurement counters")
    need(aggregate_current["model_calls"] == aggregate_all["model_calls"] == 23 and
         aggregate_current["stages"]["total"]["tokens_total"] == aggregate_all["stages"]["total"]["tokens_total"] == 2215390,
         "Remeasurement changed model charges")
    need(aggregate_all["stages"]["total"]["wall_seconds_total"] is None and
         aggregate_all["stages"]["total"]["peak_process_memory_mib_mean"] is None and
         aggregate_all["missing_measurements"] == baseline["missing_measurements"],
         "All-incurred history was incorrectly completed with fresh observations")
    current_work = group_workload(evaluation["runs"], current_rows, evaluation["group_shared_setup"])
    incurred_work = group_workload(evaluation["runs"], all_rows, evaluation["group_shared_setup"])
    same(evaluation["tespec_group_workload"], current_work, "current group workload")
    same(profile["workload"], {"current": current_work, "all_incurred": incurred_work}, "profile workloads")
    same(evaluation["historical_all_incurred_workload"], incurred_work, "historical group workload")
    need(evaluation.get("completion_basis") == SCHEMA and evaluation.get("historical_missing_measurements") == baseline["missing_measurements"], "Current completion lacks explicit historical qualification")
    return {"baseline": baseline, "current_receipts": current_rows, "all_incurred_receipts": all_rows,
            "current": aggregate_current, "all_incurred": aggregate_all,
            "current_workload": current_work, "all_incurred_workload": incurred_work}


def audit_remeasured_group(group, root, index):
    """Dedicated dispatch: proof audit remains the original frozen baseline audit."""
    import csv
    import validate_canonical_group as v
    need(group == GROUP, "Whole-check remeasurement is only published for singleton")
    reference = index["measurement_profile"]
    need(reference.get("schema", SCHEMA) == SCHEMA, "Unknown measurement profile")
    profile = _load(root, reference, v.ref)
    data = _load(root, index["canonical_evaluation"], v.ref)
    need(data.get("measurement_profile") == reference, "Index/evaluation measurement profile differs")
    result = audit_resource_remeasurement(root, profile, data)
    base = root / BASE
    table, stats, gap, outcomes = [v.load(base / name) for name in
        ("result-cost.json", "tespec/statistics.json", "coverage-gap.json", "tespec/results.json")]
    for name, value in (("index", index), ("table", table), ("statistics", stats), ("coverage", gap), ("outcomes", outcomes["summary"])):
        need(value.get("complete") is True and value.get("verdict_complete") is True and
             value.get("resource_metrics_complete") is True, "Current cohort flags differ: " + name)
    for name, value in (("index", index), ("table", table), ("statistics", stats), ("coverage", gap)):
        need(value.get("measurement_profile") == reference and value.get("current_resource_metrics_complete") is True and
             value.get("historical_cumulative_resource_metrics_complete") is False,
             "Missing current-versus-historical qualification: " + name)
    need(table.get("missing_measurements") == stats.get("missing_measurements") == [] and
         table.get("historical_missing_measurements") == stats.get("historical_missing_measurements") == result["baseline"]["missing_measurements"],
         "Published statistics hide historical measurement gaps")
    v.audit_cost_statistics(root, base, data, table, result["current_receipts"])
    same(table["group_shared_setup"], data["group_shared_setup"], "table setup")
    same(stats["group_shared_setup"], data["group_shared_setup"], "statistics setup")
    same(table["tespec_group_workload"], result["current_workload"], "table workload")
    same(stats["tespec_group_workload"], result["current_workload"], "statistics workload")
    for name, value in (("table", table), ("statistics", stats)):
        same(value["all_incurred_itp_statistics"], result["all_incurred"], name + " all-incurred costs")
        same(value["historical_all_incurred_workload"], result["all_incurred_workload"], name + " historical workload")
    with (base / "result-cost.csv").open(newline="") as stream:
        display = list(csv.DictReader(stream))
    need(len(display) == len(table["costs"]), "Current cost CSV row count differs")
    for actual, row in zip(table["costs"], display):
        for key in ("tool", "stage"):
            need(str(actual[key]) == row[key], "Current cost CSV identity differs")
        for key in ("wall_seconds", "peak_process_memory_mib", "tokens"):
            need(actual[key] is not None and float(row[key]) == actual[key], "Current cost CSV value differs")
    with (base / "cases.csv").open(newline="") as stream:
        cases = list(csv.DictReader(stream))
    need(len(cases) == len(data["runs"]) == 28, "Remeasurement changed case count")
    for actual, row in zip(data["runs"], cases):
        for key in ("case", "strategy", "spatial_smt", "expected", "raw_status", "final_status"):
            need(str(actual[key]) == row[key], "Remeasurement changed case result")
    need((base / "result-cost.md").stat().st_size > 0, "Missing current cost explanation")
    print("PASS " + GROUP + ": 28 unchanged verdicts, 14 original ITP certificates; selected whole-check remeasurement complete; historical 9 gaps retained, 29 actual checks counted.")
    return data
