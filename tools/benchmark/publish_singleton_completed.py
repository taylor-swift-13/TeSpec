#!/usr/bin/env python3
"""Compactly publish singleton after 14 complete independent ITP tasks.
Default is read-only preflight; --apply audits before increasing global progress.
This tool never launches an experiment, model or prover.
"""
from __future__ import annotations
import argparse
from collections import Counter
import copy
import csv
import hashlib
import io
import json
from pathlib import Path
import re
import statistics
import subprocess
from validate_canonical_group import (
    ROOT, audit_canonical_group, audit_cn, audit_fulminate, audit_qcp, audit_itp, ref as disk_ref,
    check_candidate_commands, digest, goal_interface, load, measurement,
    model_attempt, need, number, attempt_measurement, execution_metrics,
)
from spectest.certificates import coverage_source
from singleton_interruption import (SCHEMA as INTERRUPTION_SCHEMA, collect_interruption,
    local_path as recovery_path, artifact_file)
from singleton_native_recovery import validate_native_source
from singleton_strong_support import binding_layout, verify_native_dependencies, verify_candidate, strong_template
from singleton_canonical_support import (PROFILE, SUPPORT_SHA256, SUPPORT_PATH, canonical_sha,
    verify_attestation, combine_metrics, legacy_costs, native_cost, audit_transition, audit_shared_setup, group_workload)

GROUP = "Dbl_Linked_List__singleton"
BASE = ROOT / "benchmark/results" / GROUP
PROGRAM = ROOT / "benchmark/programs" / GROUP
CANONICAL = BASE / "evidence/tespec-native.json"
MEASUREMENT_ENVIRONMENT = "shared host with concurrent external verifier load observed; own tasks serial; timings not controlled cross-version performance comparison"
COST_FIELDS = ["tool", "stage", "unit", "wall_seconds", "peak_process_memory_mib",
               "tokens", "estimated", "status", "source"]


def encoded(value, compact=False):
    return (json.dumps(value, ensure_ascii=False, separators=(",", ":") if compact else None,
                       indent=None if compact else 2) + "\n").encode()


def rel(path):
    return str(path.resolve().relative_to(ROOT.resolve()))


def reference(path):
    return {"path": rel(path), "sha256": digest(path)}


def numbered(path):
    return int(re.search(r"(?:execution-|attempt-)([0-9]+)", path.name)[1])


def check_order(path):
    replay = re.search(r"replay-([0-9]+)", path.name)
    return (numbered(path), int(replay[1]) if replay else 0)


def collect_checks(directory):
    checks, notes = [], []
    for path in sorted(directory.glob("*.json"), key=check_order):
        value = load(path)
        if value.get("schema") in {"tespec-singleton-execution-itp/v1", "tespec-singleton-strong-left-execution-itp/v1", INTERRUPTION_SCHEMA}:
            need("status" in value, "Incomplete checker receipt: " + str(path))
            checks.append(path)
        else:
            need(path.name.endswith("-controller-interruption.json") and value.get("reason"),
                 "Unclassified checker output must not be omitted: " + str(path))
            notes.append({"name": path.name, "sha256": digest(path), "event": value,
                          "cost_scope": "Control event only; measurements are counted from its attempt receipt."})
    return checks, notes


def require_hash(path, expected, label):
    need(path.is_file() and digest(path) == expected, "Changed/missing " + label + ": " + str(path))


class Publication:
    def __init__(self):
        self.files, self.objects = {}, {}

    def put(self, path, content):
        path = path.resolve()
        need(path.is_relative_to(ROOT.resolve()), "Output escapes repository")
        if isinstance(content, str):
            content = content.encode()
        if path in self.files:
            need(self.files[path] == content, "Conflicting publication writes: " + str(path))
        self.files[path] = content
        return {"path": rel(path), "sha256": hashlib.sha256(content).hexdigest()}

    def json(self, path, value, compact=False):
        return self.put(path, encoded(value, compact))

    def object(self, source, name):
        content = source.read_bytes()
        sha = hashlib.sha256(content).hexdigest()
        if sha in self.objects:
            return copy.deepcopy(self.objects[sha])
        target = BASE / "evidence/itp/objects" / sha / name
        if target.exists():
            need(target.read_bytes() == content, "Existing proof object differs")
        result = self.put(target, content)
        self.objects[sha] = result
        return copy.deepcopy(result)

    def apply(self):
        old = {path: path.read_bytes() if path.is_file() else None for path in self.files}
        try:
            for path, content in self.files.items():
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_bytes(content)
        except BaseException:
            self.rollback(old)
            raise
        return old

    @staticmethod
    def rollback(old):
        for path, content in old.items():
            if content is None:
                path.unlink(missing_ok=True)
            else:
                path.write_bytes(content)


def prepared_evidence_reader(pub):
    """Read durable references from pending objects without publication or global patches."""
    class OverlayPath(type(Path())):
        def read_bytes(self):
            path = Path(self).resolve()
            return pub.files[path] if path in pub.files else super().read_bytes()

        def read_text(self, encoding=None, errors=None):
            return self.read_bytes().decode(encoding or "utf-8", errors or "strict")

        def open(self, mode="r", buffering=-1, encoding=None, errors=None, newline=None):
            path = Path(self).resolve()
            if path in pub.files:
                need(mode in ("r", "rt", "rb"), "Prepared evidence overlay is read-only")
                content = pub.files[path]
                return io.BytesIO(content) if "b" in mode else io.StringIO(
                    content.decode(encoding or "utf-8", errors or "strict"), newline=newline)
            return super().open(mode, buffering, encoding, errors, newline)

        def stat(self, *args, **kwargs):
            path = Path(self).resolve()
            if path in pub.files:
                from types import SimpleNamespace
                return SimpleNamespace(st_size=len(pub.files[path]), st_mode=0o100444)
            return super().stat(*args, **kwargs)

    def pending_ref(root, item):
        path = (root / item["path"]).resolve()
        need(path.is_relative_to(root.resolve()), "Prepared evidence escapes repository")
        if path in pub.files:
            need(hashlib.sha256(pub.files[path]).hexdigest() == item["sha256"], "Prepared evidence hash differs")
            return OverlayPath(path)
        return disk_ref(root, item)

    return pending_ref


def audit_prepared_execution(pub, receipt_ref, row, allow_partial=False):
    """Full read-only ITP audit, including durable recovery references."""
    return audit_itp(ROOT, receipt_ref, row, allow_partial=allow_partial, evidence_reader=prepared_evidence_reader(pub))


def audit_prepared_publication(pub, index, allow_partial=False):
    """Run the complete group auditor against pending bytes, without writes."""
    evidence = prepared_evidence_reader(pub)(ROOT, index["canonical_evaluation"])
    return audit_canonical_group(GROUP, type(evidence)(ROOT), index, allow_partial=allow_partial)


def freeze_resolution_receipt(pub, review_path, review, rows):
    """Keep the exact certificate named at resolution, independent of cost updates."""
    first = review["first_strong_certificate"]
    original = first["durable_receipt"]
    path = (ROOT / original["path"]).resolve()
    need(path.is_relative_to(BASE / "evidence/itp"), "Resolution receipt escapes group proof evidence")
    expected = original["sha256"]
    content = path.read_bytes() if path.is_file() else b""
    if hashlib.sha256(content).hexdigest() != expected:
        recovered = subprocess.run(["git", "show", "HEAD:" + original["path"]], cwd=ROOT, capture_output=True)
        need(recovered.returncode == 0 and hashlib.sha256(recovered.stdout).hexdigest() == expected,
             "Exact review-bound receipt is unavailable; do not substitute a different certificate")
        content = recovered.stdout
    existing = sorted((BASE / "evidence/itp/objects" / expected).glob("*"))
    target = existing[0] if existing else BASE / "evidence/itp/objects" / expected / "resolution-first-receipt.json"
    frozen = pub.put(target, content)
    row_index = first["native_row_index"]
    need(type(row_index) is int and 0 <= row_index < len(rows), "Invalid resolution execution")
    receipt = audit_prepared_execution(pub, frozen, rows[row_index], allow_partial=True)
    need(receipt.get("proof_profile") == PROFILE and receipt.get("native_row_index") == row_index and
         receipt.get("original_native_results_sha256") == review["resolution_native_results_sha256"] and
         canonical_sha(receipt["abi_context"]) == review["resolution_abi_context_sha256"] and
         receipt.get("strong_left_attestation_sha256") == first["strong_left_attestation_sha256"],
         "Resolution snapshot has a different proof scope or native/ABI binding")
    need(any(c.get("status") == "PASS" and c.get("controller_receipt_sha256") == first["controller_receipt_sha256"] and
             c.get("certificate_report_sha256") == first["certificate_report_sha256"] and
             c.get("candidate_sha256") == first["candidate_sha256"] for c in receipt["checks"]),
         "Resolution snapshot does not contain the originally checked certificate")
    updated = copy.deepcopy(review)
    updated["first_strong_certificate"]["durable_receipt"] = frozen
    return pub.json(review_path, updated, compact=True)


def refresh_progress_links(pub, review_ref, by_row, receipts):
    """Retain measured progress values and rebind its superseded receipt views."""
    path = BASE / "evidence/itp/abi-context/progress.json"
    if not path.is_file():
        return None
    old_ref, progress = reference(path), load(path)
    need(progress["original_entailment_completed_executions"] == len(receipts) == 14 and
         len(progress["executions"]) == 14, "Cannot retire incomplete progress as a completed proof view")
    need(progress["active_context_model_calls"] == sum(r["active_metrics"]["total"]["model_calls"] for r in receipts) and
         progress["active_context_check_attempts"] == sum(len(r["checks"]) for r in receipts) and
         progress["active_context_tokens"] == sum(r["active_metrics"]["agent"]["tokens"] for r in receipts),
         "Progress and final receipts describe different active attempts")
    by_execution = {r["execution_index"]: r for r in receipts}
    need({e["execution_index"] for e in progress["executions"]} == set(by_execution), "Progress execution inventory differs")
    for entry in progress["executions"]:
        receipt = by_execution[entry["execution_index"]]
        need(entry["status"] == receipt["status"] == "PASS" and entry["native_row_index"] == receipt["native_row_index"],
             "Progress/final proof execution identity differs")
        entry["receipt"] = by_row[entry["native_row_index"]]
    progress["semantic_review"] = review_ref
    progress["receipt_metrics_scope"] = "Receipt active_metrics is ABI-context-only; receipt metrics includes legacy context repair. Saved progress cost summaries are unchanged and are not added to final costs."
    return old_ref, pub.json(path, progress, compact=True)


def replace_progress_references(pub, replacement):
    if replacement is None:
        return
    old, new = replacement
    def rewrite(value):
        if isinstance(value, dict):
            if value.get("path") == old["path"] and value.get("sha256") == old["sha256"]:
                return {**value, **new}
            return {k: rewrite(v) for k, v in value.items()}
        return [rewrite(v) for v in value] if isinstance(value, list) else value
    for path, content in list(pub.files.items()):
        if path.suffix != ".json" or path.is_relative_to(BASE / "evidence/itp/objects"):
            continue
        value = json.loads(content)
        updated = rewrite(value)
        if updated != value:
            pub.files[path] = encoded(updated, compact=True)


def persist_interruption(pub, path, raw, task, native_sha256, model):
    """Retain exact interruption/backup evidence by hash; never manufacture a verdict."""
    check, missing = collect_interruption(raw, task, native_sha256, model, digest(path))
    check["interruption_receipt"] = pub.object(path, "infrastructure-interruption.json")
    evidence_path = recovery_path(raw["artifact_evidence"]["path"])
    evidence = json.loads(evidence_path.read_bytes().decode("utf-8-sig"))
    sources = [(raw["artifact_evidence"]["path"], evidence_path)]
    for name in ("incident", "backup_manifest"):
        sources.append((evidence[name]["path"], recovery_path(evidence[name]["path"])))
    artifact_records = evidence["preserved_artifacts"] + [item for stage in evidence["stages"] for item in (stage["resource_artifact"], stage["log_artifact"])]
    for item in artifact_records:
        actual = artifact_file(item)
        sources.extend([(item["source"], actual), (item["backup"], actual)])
    refs = {}
    for original, actual in sources:
        value = pub.object(actual, actual.name)
        need(original not in refs or refs[original] == value, "Recovery path has conflicting original bytes")
        refs[original] = value
    check["recovery_artifact_refs"] = [{"original_path": original, "evidence": value} for original, value in sorted(refs.items())]
    normalized = [{**m, "case": task["case"], "strategy": task["strategy"], "spatial_smt": task["mode"]} for m in missing]
    check["missing_measurements"] = normalized
    return check, normalized


def persist_native_recovery(pub, task, baseline_native_path, baseline_sha256):
    """Freeze measured recovery inputs; runtime objects already in the repo stay shared."""
    row, audit = validate_native_source(task, baseline_native_path, baseline_sha256)
    refs = []
    for item in audit["artifacts"]:
        path = recovery_path(item["path"])
        require_hash(path, item["sha256"], "native recovery artifact")
        value = reference(path) if path.resolve().is_relative_to(ROOT.resolve()) else pub.object(path, path.name)
        refs.append({"original_path": item["path"], "evidence": value})
    binding_record = task.get("native_recovery_binding")
    binding_path = Path(binding_record["path"]) if binding_record else Path(task["certificate_dir"]) / "binding.json"
    if binding_record:
        require_hash(binding_path, binding_record["sha256"], "native recovery binding sidecar")
    binding = pub.object(binding_path, "native-task-binding.json")
    need(load(binding_path) == {k: v for k, v in task.items() if k != "native_recovery_binding"}, "Native recovery task binding file differs")
    return row, {"task": copy.deepcopy(task), "audit": audit, "artifacts": refs, "binding": binding}


def prepare_shared_setup(pub, transition, overrides_path=None):
    setup = copy.deepcopy(transition["group_shared_setup"])
    if overrides_path is not None:
        receipt_path = overrides_path.parent / "recovery-setup.json"
        resources_path = overrides_path.parent / "recovery-setup.resources"
        script_path = overrides_path.parent.parent / "prepare-singleton-native-overrides.py"
        receipt, text = load(receipt_path), resources_path.read_text()
        values = re.fullmatch(r"wall_seconds=([0-9.]+)(?:n|\n)user_seconds=([0-9.]+)(?:n|\n)system_seconds=([0-9.]+)(?:n|\n)max_process_rss_kib=([0-9]+)\s*", text)
        need(values is not None, "Recovery setup lacks external GNU time values")
        wall, user, system, rss = values.groups()
        setup["native_recovery_preparation"] = {"wall_seconds": float(wall), "peak_process_rss_kib": int(rss),
            "cpu_user_seconds": float(user), "cpu_system_seconds": float(system), "tokens": 0, "model_calls": 0,
            "receipt": pub.object(receipt_path, receipt_path.name), "resources": pub.object(resources_path, resources_path.name),
            "source": pub.object(script_path, script_path.name), "raw_resources": text,
            "internal_python_wall_seconds_diagnostic_only": receipt["wall_seconds"], "captured_actual_argv": None,
            "command_evidence": "GNU time preserved external wall/CPU/RSS. Actual /proc argv was not captured; the internal Python timer is diagnostic only.",
            "scope": "One recovery preparation per group, excluded from per-execution ITP means."}
    return setup


def usage_events(path):
    events = []
    for line in path.read_text(errors="replace").splitlines():
        try:
            event = json.loads(line)
        except ValueError:
            continue
        if event.get("type") == "turn.completed" and isinstance(event.get("usage"), dict):
            events.append(event)
    return events


def checked_models(directory):
    folders = sorted((p for p in directory.glob("attempt-*") if p.is_dir()), key=numbered)
    need(folders, "No model attempts: " + str(directory))
    models = []
    for folder in folders:
        path = folder / "model-receipt.json"
        need(path.is_file(), "A model attempt is still running or lacks receipt: " + str(folder))
        model = load(path)
        need(model["attempt"] == numbered(folder), "Model attempt ordinal mismatch")
        model_attempt(model, str(folder))
        for filename, key in (("agent.stdout.jsonl", "raw_event_log_sha256"),
                              ("prompt.txt", "prompt_sha256"), ("Candidate.v", "candidate_sha256")):
            require_hash(folder / filename, model[key], filename)
        events = usage_events(folder / "agent.stdout.jsonl")
        need([event["usage"] for event in events] == model["token_usage"], "Actual token events differ")
        model = copy.deepcopy(model)
        model.update(usage_events=events, source_receipt_sha256=digest(path))
        models.append(model)
    need(len({m["attempt"] for m in models}) == len(models), "Duplicate model attempts")
    return models


def stage_totals(stages):
    need(stages, "Missing actually measured stage")
    observed = [(s.get("resources") or {}).get("max_process_rss_kib") for s in stages]
    complete = all(v is not None for v in observed)
    known = [v for v in observed if v is not None]
    return {"wall_seconds": sum(s["wall_seconds"] for s in stages),
            "peak_process_rss_kib": max(known) if complete else None,
            "observed_peak_rss_lower_bound_kib": max(known) if known else None,
            "resource_metrics_complete": complete, "tokens": 0, "subprocesses": len(stages)}


def build_execution(pub, task, native, itp_root, model_root, transition_mapping=None):
    index = task["execution_index"]
    baseline_native = native
    native_recovery = None
    proof_row_index = task["native_row_index"]
    if task.get("native_source"):
        source = task["native_source"]
        row, native_recovery = persist_native_recovery(pub, task, Path(source["original_native_result"]), native["_sha256"])
        need(baseline_native["_sha256"] == source["original_native_result_sha256"], "Recovery baseline differs from publication")
        native = load(Path(source["native_result"]))
        native["_sha256"] = source["native_result_sha256"]
        proof_row_index = source["native_row_index"]
    else:
        row = native["runs"][task["native_row_index"]]
    for key, other in (("case", "case"), ("mode", "spatial_smt"), ("strategy", "strategy"),
                       ("input", "input"), ("source_sha256", "source_sha256")):
        need(task[key] == row[other], "Task/native execution identity differs")
    need(row["raw_status"] == "UNKNOWN" and row["expected"] == "PASS"
         and row["execution_completed"] is True and row["precondition_result"] == "SAT",
         "ITP task is not a completed legal positive execution")
    need(task["residual_vcs"] == row["residual_vcs"], "Residual VC inventory differs")
    strong = "abi_context" in task or "strong_template" in task
    required = ["original_report", "original_manifest", "original_goal", "certificate_manifest"]
    if not strong:
        required.append("controller_manifest")
    for name in required:
        require_hash(Path(task[name]), task[name + "_sha256"], name)
    require_hash(ROOT / task["source"], task["source_sha256"], "program source")
    if strong:
        require_hash(ROOT / SUPPORT_PATH, SUPPORT_SHA256, "executed strong binding helper")
        original = load(Path(task["original_manifest"]))
        context = binding_layout(task["abi_context"]["bundle"], original["target_layout"])
        need(context == task["abi_context"], "Strong task ABI context differs")
        verify_native_dependencies(original, context)
        need(strong_template(Path(task["original_goal"]).read_bytes())[2] == task["strong_template"], "Task strong statement differs from original Goal")
        certificate = load(Path(task["certificate_manifest"]))
        need(certificate["original_manifest_sha256"] == task["original_manifest_sha256"] and certificate["target_layout"] == original["target_layout"], "Strong certificate context differs")
    model_dir = model_root / f"execution-{index:02d}"
    need(model_dir.resolve() == Path(task["model_dir_wsl"]).resolve(), "Model root differs from task")
    models = checked_models(model_dir)
    model_by_hash = {m["source_receipt_sha256"]: m for m in models}
    check_paths, controller_notes = collect_checks(itp_root / "checks" / f"execution-{index:02d}")
    need(check_paths, "No Coq checks: " + str(index))
    checks, completed = [], []
    for path in check_paths:
        raw, attempt = load(path), numbered(path)
        need(raw["model_receipt_sha256"] in model_by_hash, "Coq check has no metered model attempt")
        model = model_by_hash[raw["model_receipt_sha256"]]
        need(raw["model_receipt_sha256"] == model["source_receipt_sha256"], "Coq/model receipt differs")
        if raw.get("schema") == INTERRUPTION_SCHEMA:
            need(strong, "Infrastructure recovery evidence requires the strong task profile")
            check, _missing = persist_interruption(pub, path, raw, task, native["_sha256"], model)
            checks.append(check)
            continue
        need(raw["native_row_index"] == proof_row_index, "Check points at another execution")
        need(raw["native_results_sha256"] == native["_sha256"], "Check native snapshot mismatch")
        if native_recovery is not None:
            need(raw.get("native_recovery_binding_sha256") == native_recovery["binding"]["sha256"] and raw.get("native_recovery_audit") == native_recovery["audit"], "Checker lacks the exact recovery task/native binding")
        binding = raw["binding"]
        need(binding["original_goal_sha256"] == task["original_goal_sha256"]
             and binding["original_residual_vcs"] == task["residual_vcs"]
             and binding["source_sha256"] == task["source_sha256"], "Check original binding mismatch")
        need(binding["precondition_result"] == "SAT" and binding["execution_completed"] is True,
             "Check native entry/exit incomplete")
        if strong:
            need(raw.get("schema") == "tespec-singleton-strong-left-execution-itp/v1" and raw.get("support_sha256") == SUPPORT_SHA256, "Strong task checked with legacy policy")
            actual_candidate = model_dir / f"attempt-{model['attempt']}" / "Candidate.v"
            candidate_binding = verify_candidate(actual_candidate.read_bytes(), Path(task["original_goal"]).read_bytes())
            need(binding.get("strong_left") == candidate_binding and binding.get("abi_context") == context and binding.get("external_definitions") == context["modules"], "Strong checker candidate/context binding differs")
            need(binding.get("original_manifest_sha256") == task["original_manifest_sha256"] and raw.get("certificate_manifest_sha256") == task["certificate_manifest_sha256"], "Strong checker native manifest differs")
            if raw.get("status") == "KERNEL_CHECKED":
                verify_attestation(raw.get("strong_left_attestation"), Path(task["original_goal"]).read_bytes(), actual_candidate.read_bytes(), context, task["certificate_manifest_sha256"], raw["certificate_report_sha256"])
                need(raw.get("strong_left_attestation_sha256") == canonical_sha(raw["strong_left_attestation"]), "Strong checker attestation hash differs")
        report_path = Path(raw["certificate_report"])
        require_hash(report_path, raw["certificate_report_sha256"], "checker report")
        report = load(report_path)
        need(report == raw["certificate_result"], "Embedded checker report differs")
        need(len(raw["stages"]) == len(report["stages"]), "Measured checker stages omit or repeat a reported subprocess")
        for measured, reported in zip(raw["stages"], report["stages"]):
            need(all(measured.get(k) == value for k, value in reported.items()), "Measured checker stages differ in order, cost or command from the hashed production report")
        need(report["candidate_sha256"] == model["candidate_sha256"], "Checked candidate differs from model")
        check = {k: copy.deepcopy(v) for k, v in report.items() if k not in {"stages", "duration_seconds"}}
        check.update(attempt=path.stem, model_attempt=model["attempt"], model_receipt_sha256=raw["model_receipt_sha256"], selected_goals=task["residual_vcs"], controller_receipt_sha256=digest(path),
                     certificate_report_sha256=raw["certificate_report_sha256"],
                     controller_sha256=raw["controller_sha256"], checker_sha256=raw["checker_sha256"])
        if strong:
            for name in ("binding", "support_sha256", "certificate_manifest_sha256", "strong_left_attestation", "strong_left_attestation_sha256", "native_recovery_binding_sha256", "native_recovery_audit"):
                if name in raw:
                    check[name] = copy.deepcopy(raw[name])
        check["stages"] = []
        for measured in raw["stages"]:
            attempt_measurement(measured, "Coq/kernel attempt", allow_missing_rss=report.get("status") != "PASS")
            require_hash(Path(measured["log"]), measured["log_sha256"], "stage log")
            check["stages"].append({k: copy.deepcopy(v) for k, v in measured.items() if k != "log"})
        audit = raw.get("assumption_audit_text")
        if audit is not None:
            check.update(audit_text=audit, audit_sha256=hashlib.sha256(audit.encode()).hexdigest())
        checks.append(check)
        if raw.get("status") == "KERNEL_CHECKED" and raw.get("final_status") == "PASS" and raw["model_receipt_sha256"] == models[-1]["source_receipt_sha256"]:
            completed.append((raw, check))
    need(completed, "Execution has not completed independent kernel checking for its latest candidate: " + str(index))
    final, selected_check = completed[-1]
    need(selected_check["status"] == "PASS" and selected_check.get("kernel_replay_mode") == "full",
         "Execution lacks a successful independent full kernel check: " + str(index))
    need(final["model_receipt_sha256"] == models[-1]["source_receipt_sha256"], "Unchecked later model attempt exists")
    proof_dir = Path(final["certificate_report"]).parent
    manifest = load(proof_dir / "manifest.json")
    need(manifest["selected_goals"] == task["residual_vcs"], "Selected original goals changed")
    require_hash(proof_dir / "Goal.v", task["original_goal_sha256"], "final original Goal")
    require_hash(proof_dir / "Candidate.v", models[-1]["candidate_sha256"], "final Candidate")
    check_candidate_commands((proof_dir / "Candidate.v").read_text())
    selected = [(n, s) for n, s in goal_interface((proof_dir / "Goal.v").read_text()) if n in task["residual_vcs"]]
    need((proof_dir / "Coverage.v").read_text() == coverage_source(selected, partial=True),
         "Checked Coverage does not implement every original selected goal")
    goal, candidate = pub.object(proof_dir / "Goal.v", "Goal.v"), pub.object(proof_dir / "Candidate.v", "Candidate.v")
    proof_files = {name: pub.object(proof_dir / name, name) for name in ("Coverage.v", "Assumptions.v")}
    if (proof_dir / "AssumptionIdentities.v").is_file():
        proof_files["AssumptionIdentities.v"] = pub.object(proof_dir / "AssumptionIdentities.v", "AssumptionIdentities.v")
    dependencies = []
    for dep in manifest["dependencies"]:
        source = proof_dir / dep["file"]
        require_hash(source, dep["sha256"], "checked external definition")
        item = pub.object(source, Path(dep["file"]).name)
        item["module"] = dep["module"]
        dependencies.append(item)
    for model in models:
        need(model["locked_goal_and_helper_sha256"]["Goal.v"] == task["original_goal_sha256"], "Model Goal changed")
        for dep in dependencies:
            need(model["locked_goal_and_helper_sha256"][Path(dep["path"]).name] == dep["sha256"], "Model dependency changed")
    metrics = execution_metrics(models, checks)
    missing = []
    for check in checks:
        if check.get("schema") == INTERRUPTION_SCHEMA:
            missing.extend(check["missing_measurements"])
        else:
            missing.extend({"execution_index": index, "case": row["case"], "strategy": row["strategy"], "spatial_smt": row["spatial_smt"],
                "check_attempt": check["attempt"], "stage": stage["stage"], "field": "resources.max_process_rss_kib",
                "reason": "Original failed stage did not retain RSS; later reruns cannot replace it.",
                "wall_seconds": stage["wall_seconds"], "exit_code": stage["exit_code"], "log_sha256": stage["log_sha256"]}
                for stage in check["stages"] if (stage.get("resources") or {}).get("max_process_rss_kib") is None)
    receipt = {"schema": "tespec-canonical-execution-itp/v1", "status": "PASS", "group": GROUP,
        "resource_metrics_complete": not missing, "missing_measurements": missing,
        "controller_notes": controller_notes, "measurement_environment": MEASUREMENT_ENVIRONMENT,
        "execution_index": index, "case": row["case"], "strategy": row["strategy"], "spatial_smt": row["spatial_smt"],
        "input": row["input"], "source_sha256": row["source_sha256"], "original_goal_sha256": task["original_goal_sha256"],
        "original_report_sha256": task["original_report_sha256"], "original_manifest_sha256": task["original_manifest_sha256"],
        "goal": goal, "candidate": candidate, "proof_files": proof_files, "dependencies": dependencies,
        "selected_goals": task["residual_vcs"], "model_attempts": models, "checks": checks,
        "selected_check_sha256": selected_check["controller_receipt_sha256"],
        "metrics": metrics,
        "scope": "One execution and all original residual VCs; every repair attempt counted. Independent full kernel replay per execution; proof deduplication shares storage only."}
    namespace = "abi-context/" if strong else ""
    if strong:
        need(digest(proof_dir / "manifest.json") == task["certificate_manifest_sha256"], "Selected strong certificate manifest changed")
        receipt.update(proof_profile=PROFILE, abi_context=context, strong_template=task["strong_template"],
            native_row_index=task["native_row_index"], proof_native_row_index=proof_row_index,
            original_native_results_sha256=native["_sha256"], baseline_native_results_sha256=baseline_native["_sha256"],
            support=reference(ROOT / SUPPORT_PATH),
            original_manifest=pub.object(Path(task["original_manifest"]), "native-manifest.json"),
            certificate_manifest=pub.object(proof_dir / "manifest.json", "certificate-manifest.json"),
            strong_left_attestation=final["strong_left_attestation"],
            strong_left_attestation_sha256=final["strong_left_attestation_sha256"],
            active_metrics=copy.deepcopy(receipt["metrics"]), active_missing_measurements=copy.deepcopy(missing),
            active_resource_metrics_complete=not missing, legacy_cost_receipts=[])
        receipt["missing_measurements"] = [{**m, "proof_context": "active"} for m in missing]
        if native_recovery is not None:
            receipt["native_recovery"] = native_recovery
        if transition_mapping is not None:
            need(transition_mapping["active_itp_execution_index"] == index and transition_mapping["active_native_row_index"] == task["native_row_index"], "Legacy cost mapping targets another active task")
            legacy = transition_mapping["legacy_itp_receipt"]
            receipt["legacy_cost_receipts"] = [legacy] if legacy else []
            old_metrics, old_missing = legacy_costs(ROOT, receipt["legacy_cost_receipts"], row)
            receipt["legacy_metrics"] = old_metrics
            receipt["metrics"] = combine_metrics(old_metrics + [receipt["active_metrics"]])
            receipt["missing_measurements"] = old_missing + [{**m, "proof_context": "active"} for m in missing]
            receipt["resource_metrics_complete"] = not receipt["missing_measurements"]
        receipt["scope"] = "Exact original left Dll entailment and original parent under explicit target-layout definitions; legacy equivalence is not certified. Legacy parent proofs count only as repair cost. All attempts remain counted."
    receipt_ref = pub.json(BASE / f"evidence/itp/{namespace}execution-{index:02d}.json", receipt, compact=True)
    return receipt, receipt_ref



def aggregate_itp(receipts):
    need(receipts, "No complete execution ITP receipts")
    result = {"executions": len(receipts),
              "model_calls": sum(r["metrics"]["total"]["model_calls"] for r in receipts),
              "check_attempts": sum(r["metrics"]["total"]["check_attempts"] for r in receipts),
              "stages": {}}
    for name in ("agent", "coq_compile_and_assumption_audit", "independent_kernel_check", "total"):
        values = [r["metrics"][name] for r in receipts]
        peaks = [v["peak_process_resident_bytes"] if "peak_process_resident_bytes" in v
                 else (v["peak_process_rss_kib"] * 1024 if v["peak_process_rss_kib"] is not None else None) for v in values]
        time_complete = all(v["wall_seconds"] is not None for v in values)
        total_time = sum(v["wall_seconds"] for v in values) if time_complete else None
        tokens = sum(v["tokens"] for v in values)
        result["stages"][name] = {
            "wall_seconds_total": total_time, "wall_seconds_mean": total_time / len(values) if total_time is not None else None,
            "peak_process_memory_mib_mean": statistics.mean(peaks) / 1048576 if all(v is not None for v in peaks) else None,
            "peak_process_memory_mib_max": max(peaks) / 1048576 if all(v is not None for v in peaks) else None,
            "resource_metrics_complete": all(v is not None for v in peaks),
            "tokens_total": tokens, "tokens_mean": tokens / len(values)}
        if not time_complete:
            lower = sum(v.get("known_wall_seconds_lower_bound", v.get("wall_seconds")) or 0 for v in values)
            result["stages"][name].update(wall_time_complete=False, known_wall_seconds_lower_bound_total=lower, known_wall_seconds_lower_bound_mean=lower / len(values))
    result["resource_metrics_complete"] = all(r.get("resource_metrics_complete") is True for r in receipts)
    result["missing_measurements"] = [m for r in receipts for m in r.get("missing_measurements", [])]
    result["metric_scope"] = ("Every attempt counted once; one execution and all original residual VCs is one ITP. "
                              "Independent sequential agent, compiler/audit and kernel stages. "
                              "Peak is maximum process RSS inside a stage, not a sum; display means are means of per-execution peaks.")
    return result


def csv_bytes(rows, fields):
    stream = io.StringIO(newline="")
    writer = csv.DictWriter(stream, fieldnames=fields, extrasaction="ignore", lineterminator=chr(10))
    writer.writeheader()
    writer.writerows(rows)
    return stream.getvalue().encode()


def cost_row(tool, stage, seconds, peak, tokens, source, unit="每次执行均值；内存为逐次峰值均值"):
    return {"tool": tool, "stage": stage, "unit": unit, "wall_seconds": seconds,
            "peak_process_memory_mib": peak, "tokens": tokens, "estimated": False,
            "status": "PARTIAL_MISSING_METRICS" if seconds is None else "MEASURED" if peak is not None else "PARTIAL_MISSING_RSS", "source": source}


def mode_statistics(rows, receipts):
    result = {}
    for strategy in ("inline", "modular"):
        for mode in ("off", "on"):
            selected = [r for r in rows if r["strategy"] == strategy and r["spatial_smt"] == mode]
            need(len(selected) == 7, "Missing native strategy/mode coverage")
            proofs = [r for r in receipts if r["strategy"] == strategy and r["spatial_smt"] == mode]
            result[strategy + ":" + mode] = {
                "execution_strategy": strategy, "spatial_smt": mode, "executions": len(selected),
                "native_status_counts": dict(Counter(r["raw_status"] for r in selected)),
                "final_status_counts": dict(Counter(r["final_status"] for r in selected)),
                "expected_matches": sum(r["final_status"] == r["expected"] for r in selected),
                "execution_wall_seconds_total": sum(native_cost(r)[0] for r in selected),
                "mean_execution_wall_seconds": statistics.mean(native_cost(r)[0] for r in selected),
                "mean_execution_peak_rss_mib": statistics.mean(native_cost(r)[1] for r in selected) / 1024,
                "maximum_execution_peak_rss_mib": max(native_cost(r)[1] for r in selected) / 1024,
                "native_tokens": 0, "native_model_calls": 0,
                "completed_independent_itp_executions": len(proofs), "pending_independent_itp_executions": 0,
                "itp": aggregate_itp(proofs) if proofs else {"status": "NOT_REQUIRED", "executions": 0}}
    return result


def prepare(itp_root, model_root, native_path, task_overrides=None):
    layout_audit = ROOT / "benchmark/results/tespec-unexpected/singleton-external-layout.json"
    if layout_audit.is_file() and load(layout_audit).get("status") == "OPEN":
        raise ValueError(
            "Publication blocked: singleton external-layout semantic audit is OPEN; "
            "legacy parent proofs do not independently establish the original Dll "
            "entailment or its correspondence with the target ABI."
        )
    tasks_path = itp_root / "tasks.json"
    inventory, native = load(tasks_path), load(native_path)
    need(inventory["group"] == native["group"] == GROUP, "Wrong group")
    need(inventory.get("schema") == "tespec-singleton-strong-left-tasks/v1", "Singleton completion requires the ABI-bound strong-left task profile; legacy parent proofs are cost evidence only")
    require_hash(native_path, inventory["native_result_sha256"], "native snapshot")
    native["_sha256"] = digest(native_path)
    tasks = sorted(inventory["tasks"], key=lambda t: t["execution_index"])
    overrides = None
    if task_overrides is not None:
        overrides = load(task_overrides)
        need(overrides.get("schema") == "tespec-singleton-task-overrides/v1" and overrides.get("original_tasks_sha256") == digest(tasks_path) and overrides.get("baseline_native_results_sha256") == native["_sha256"], "Native task override envelope differs from original inventory")
        replaced = {t["execution_index"]: t for t in overrides["overrides"]}
        need(set(replaced) == {4, 5, 8, 9, 10, 13} and len(replaced) == len(overrides["overrides"]), "Recovery overrides must cover exactly the six unstarted tasks")
        for position, task in enumerate(tasks):
            if task["execution_index"] in replaced:
                new = replaced[task["execution_index"]]
                need(new["native_source"]["original_task"] == task, "Override changes the original immutable task")
                tasks[position] = new
    need([t["execution_index"] for t in tasks] == list(range(14)), "Expected exactly 14 independent tasks")
    need(len(native["runs"]) == 28 and native["case_pairs"] == 7
         and native["input_evidence_unchanged"] is True and not native["changed"], "Native coverage/source audit incomplete")
    need(len({t["native_row_index"] for t in tasks}) == 14, "Tasks repeat one execution")
    for task in tasks:
        checks, _notes = collect_checks(itp_root / "checks" / f"execution-{task['execution_index']:02d}")
        need(checks and any(load(path).get("status") == "KERNEL_CHECKED" for path in checks),
             "Publication blocked: execution-%02d is not KERNEL_CHECKED" % task["execution_index"])
    for path, value in native["input_identity"].items():
        require_hash(ROOT / path, value, "native source/runtime input")
    plan_path, group_manifest_path = PROGRAM / "evaluation-plan.json", PROGRAM / "manifest.json"
    plan, group_manifest = load(plan_path), load(group_manifest_path)
    variants, sources = {}, {}
    for item in group_manifest["variants"]:
        variant = load(ROOT / item["manifest"])
        variants[variant["id"]] = variant
        for entry in variant["files"].values():
            require_hash(ROOT / entry["path"], entry["sha256"], "variant source")
            sources[entry["path"]] = entry["sha256"]
    cases = {(pair["cn_variant"], case["id"]): (case, pair)
             for pair in plan["pairings"] for case in pair["cases"]}
    need(len(cases) == 7, "Changed official input denominator")
    tool_refs = {tool: reference(BASE / tool / "results.json") for tool in ("cn", "fulminate", "qcp")}
    tool_publications = {tool: load(ROOT / item["path"]) for tool, item in tool_refs.items()}
    tool_receipts = {tool: reference(ROOT / tool_publications[tool]["receipt" if tool == "qcp" else "evidence"])
                     for tool in tool_refs}
    cn = audit_cn(ROOT, tool_publications["cn"], GROUP, sources, plan["function"])
    fulminate = audit_fulminate(ROOT, tool_publications["fulminate"], cases)
    qcp = audit_qcp(ROOT, tool_publications["qcp"], sources)
    historical_logs = [cn.get("cn", cn)] + [m for run in fulminate["runs"] for m in (run["pipeline"], run["test"])]
    historical_logs += qcp["compilation"] + [qcp["kernel_check"]]
    tool_log_refs = {path: reference(ROOT / path) for m in historical_logs
                     for path in (m["stdout"], m["stderr"])}
    strong = inventory.get("schema") == "tespec-singleton-strong-left-tasks/v1"
    transition_ref, transition_map = None, {}
    if strong:
        need(inventory.get("support_script_sha256") == SUPPORT_SHA256, "Strong task support policy differs")
        transition_ref = reference(BASE / "evidence/itp/context-transition.json")
        transition, transition_map = audit_transition(ROOT, transition_ref, native["runs"], native["_sha256"], tasks[0]["abi_context"])
        review = load(layout_audit)
        need(review.get("status") == "RESOLVED_FOR_EXPLICIT_ABI_CONTEXT" and review.get("resolution_native_results_sha256") == native["_sha256"], "Strong publication requires review resolved for this native context")
        need(review.get("legacy_review_snapshot") == transition["semantic_review"], "Resolved review lacks frozen legacy audit reference")
        need(review.get("resolution_abi_context_sha256") == canonical_sha(tasks[0]["abi_context"]) and review.get("legacy_context_status") == "NOT_CERTIFIED", "Semantic resolution must bind the explicit ABI and retain legacy limit")
    pub, receipts, by_row = Publication(), [], {}
    for task in tasks:
        receipt, receipt_ref = build_execution(pub, task, native, itp_root, model_root, transition_map.get(task["native_row_index"]))
        receipts.append(receipt)
        by_row[task["native_row_index"]] = receipt_ref
    receipts_by_row = {r["native_row_index"]: r for r in receipts}
    rows = []
    for position, raw in enumerate(native["runs"]):
        row = {k: copy.deepcopy(v) for k, v in raw.items() if k not in {"vc_files", "report", "itp", "spatial"}}
        if strong:
            m = transition_map[position]
            row["native_attempts"] = [copy.deepcopy(m["legacy_native_stage"]), copy.deepcopy(m["active_native_stage"])]
            row["context_transition_execution_key"] = m["execution_key"]
            proof = receipts_by_row.get(position)
            if proof and proof.get("native_recovery"):
                stage = proof["native_recovery"]["audit"]["new_native_stage"]
                row["native_attempts"].append({"wall_seconds": stage["wall_seconds"], "peak_process_rss_kib": stage["resources"]["max_process_rss_kib"], "tokens": stage["tokens"], "model_calls": stage["model_calls"], "command_sha256": canonical_sha(stage["command"]), "report_sha256": stage["report_sha256"]})
                row["proof_native_results_sha256"] = proof["original_native_results_sha256"]
                row["proof_native_row_index"] = proof["proof_native_row_index"]
        row["vc_sha256"] = {name: entry["sha256"] for name, entry in raw["vc_files"].items()}
        if raw.get("spatial") is not None:
            row["spatial"] = copy.deepcopy(raw["spatial"])
        if position in by_row:
            row.update(final_status="PASS", itp="KERNEL_CHECKED", itp_receipt=by_row[position],
                       final_reason="All original residual VCs proved; assumptions audited; independent full kernel replay passed.")
        else:
            need(raw["raw_status"] == "PASS" and not raw["residual_vcs"], "Unproved native execution")
            row.update(itp="NOT_REQUIRED")
        row["matches_expected"] = row["final_status"] == row["expected"]
        rows.append(row)
    need(all(r["matches_expected"] for r in rows), "Final mismatch remains")
    layout_review_ref = freeze_resolution_receipt(pub, layout_audit, review, rows) if strong else reference(layout_audit)
    progress_replacement = refresh_progress_links(pub, layout_review_ref, by_row, receipts) if strong else None
    shared_setup = prepare_shared_setup(pub, transition, task_overrides)
    workload = group_workload(rows, receipts, shared_setup)
    statistics_itp, modes = aggregate_itp(receipts), mode_statistics(rows, receipts)
    resources_complete = statistics_itp["resource_metrics_complete"]
    missing = statistics_itp["missing_measurements"]
    old_canonical_hash = digest(CANONICAL) if CANONICAL.is_file() else None
    if CANONICAL.is_file():
        prior = load(CANONICAL)
        if prior.get("schema") == "tespec-canonical-group-evaluation/v1":
            need(prior["original_native_results_sha256"] == native["_sha256"], "Cannot mix a new native run into old ITP publication")
            old_canonical_hash = prior["previous_native_publication_sha256"]
    evaluation = {
        "schema": "tespec-canonical-group-evaluation/v1", "group": GROUP,
        "complete": resources_complete, "verdict_complete": True, "resource_metrics_complete": resources_complete,
        "missing_measurements": missing,
        "measurement_environment": MEASUREMENT_ENVIRONMENT,
        "group_shared_setup": shared_setup, "tespec_group_workload": workload,
        "repository_commit": native["repository_commit"], "plan_sha256": digest(plan_path),
        "source_refs": [{"path": path, "sha256": value} for path, value in sorted(sources.items())],
        "input_identity": native["input_identity"], "input_evidence_unchanged": True,
        "original_native_results_sha256": native["_sha256"],
        "previous_native_publication_sha256": old_canonical_hash,
        "task_inventory_sha256": digest(tasks_path),
        "tool_evidence": tool_refs, "tool_receipt_refs": tool_receipts,
        "tool_statistics_refs": {tool: reference(BASE / tool / "statistics.json") for tool in tool_refs},
        "tool_log_refs": list(tool_log_refs.values()), "case_pairs": 7, "native_executions": 28,
        "itp_executions": 14, "pending_itp_executions": 0,
        "raw_status_counts": dict(Counter(r["raw_status"] for r in rows)),
        "final_status_counts": dict(Counter(r["final_status"] for r in rows)),
        "runs": rows, "scope": "Seven original legal input pairs across inline/modular and spatial SMT OFF/ON. Four configurations do not multiply the input-pair denominator. CN/QCP prove only the primary program under its recorded allocator contracts."}
    if strong:
        evaluation.update(proof_profile=PROFILE, context_transition=transition_ref,
            abi_context=tasks[0]["abi_context"], semantic_review=layout_review_ref,
            native_cost_scope="Each logical execution includes legacy and ABI native attempts once; input denominator unchanged.")
    if overrides is not None:
        evaluation["task_overrides"] = pub.object(task_overrides, "tasks-overrides.json")
        evaluation["original_task_inventory"] = pub.object(tasks_path, "original-tasks.json")
    evaluation_ref = pub.json(CANONICAL, evaluation, compact=True)
    latest = {"evidence": evaluation_ref["path"], "sha256": evaluation_ref["sha256"], "case_pairs": 7,
              "executions": 28, "complete": resources_complete, "verdict_complete": True,
              "resource_metrics_complete": resources_complete, "pending_itp_executions": 0,
              "completed_independent_itp_executions": 14, "original_native_results_sha256": native["_sha256"],
              "previous_native_publication_sha256": old_canonical_hash}
    summary = {"case_pairs": 7, "correct": 7, "executions": 28, "correct_executions": 28,
               "native_status_counts": evaluation["raw_status_counts"], "final_status_counts": {"PASS": 28},
               "itp_required_executions": 14, "itp_kernel_checked_executions": 14,
               "complete": resources_complete, "verdict_complete": True, "resource_metrics_complete": resources_complete}
    stats = {"schema": "tespec-group-test-costs/v1", "program_group": GROUP,
             "complete": resources_complete, "verdict_complete": True, "resource_metrics_complete": resources_complete,
              "group_shared_setup": shared_setup, "tespec_group_workload": workload,
             "missing_measurements": missing, "case_pairs": 7, "executions": 28,
             "tokens": statistics_itp["stages"]["total"]["tokens_total"],
             "model_calls": statistics_itp["model_calls"], "itp_required_executions": 14,
             "itp_completed_executions": 14, "modes": modes, "itp_statistics": statistics_itp,
             "latest_native_recheck": latest,
             "measurement_environment": MEASUREMENT_ENVIRONMENT,
             "metric_scope": "Native CLI includes its executor and spatial solver; nested executor measurements are diagnostic and not added. Agent, Coq/audit, independent kernel are disjoint. Includes every proof repair attempt."}
    pub.json(BASE / "tespec/statistics.json", stats)
    pub.json(BASE / "tespec/results.json", {"tool": "tespec", "program_group": GROUP, "summary": summary,
        "evidence": evaluation_ref["path"], "evidence_sha256": evaluation_ref["sha256"],
        "latest_native_recheck": latest, "cases": [{k: r[k] for k in ("case", "variant", "strategy", "spatial_smt", "expected", "raw_status", "final_status", "matches_expected")} for r in rows]})
    table = load(BASE / "result-cost.json")
    need(table.get("complete") is not True, "Group already complete; do not republish over existing canonical evidence")
    # Progress rows summarize these same attempts and must not be counted again.
    progress_sources = {rel(BASE / "evidence/itp" / name) for name in ("progress.json", "abi-context/progress.json", "context-transition.json")}
    previous_costs = [row for row in table["costs"] if row.get("source") not in progress_sources]
    if "current_itp_progress" in table:
        table["historical_itp_progress"] = table.pop("current_itp_progress")
    table.pop("current_measured_itp_stages", None)
    table.pop("current_missing_measurements", None)
    need([r["tool"] for r in previous_costs[:8]] == ["cn", "qcp", "qcp", "qcp", "qcp", "qcp", "fulminate", "fulminate"],
         "Historical tool rows changed")
    if not table.get("canonical_evaluation") and "pre_context_transition_cost_views" in table:
        # The progress publisher replaces the active native/ITP display rows.
        # Recover the original 33-row partition from its frozen display snapshot;
        # none of these views is added to the independently reconstructed costs.
        saved = table["pre_context_transition_cost_views"]["costs"]
        need(len(saved) == 28 and [r["stage"] for r in saved[25:]] ==
             ["agent", "coq_compile_and_assumption_audit", "independent_kernel_check"] and
             all(r["tool"] == "tespec current ITP" and r.get("source") ==
                 rel(BASE / "evidence/itp/legacy-context/progress.json") for r in saved[25:]),
             "Preserved historical ITP summary layout changed")
        need([r["tool"] for r in saved[21:25]] ==
             ["tespec inline spatial-off", "tespec inline spatial-on", "tespec modular spatial-off", "tespec modular spatial-on"] and
             all(r.get("status") == "MEASURED_NATIVE_ONLY" and r.get("source") == rel(CANONICAL) for r in saved[21:25]),
             "Preserved historical native display layout changed")
        previous_costs = previous_costs[:8] + copy.deepcopy(saved[:25])
    if table.get("canonical_evaluation"):
        need(len(previous_costs) in (16, 17, 18) and "historical_attempts" in table, "Partial publication cost layout changed")
        require_hash(ROOT / table["canonical_evaluation"]["path"], table["canonical_evaluation"]["sha256"], "previous canonical publication")
    else:
        need(len(previous_costs) == 33, "Historical table changed; review cost partition before publication")
        table["historical_attempts"] = {"costs": previous_costs[8:29],
            "evaluation_notes": table.get("evaluation_notes", []), "test_modes": table.get("test_modes"),
            "scope": "Prior native attempts, failures, repairs and unmeasured placeholders. Missing historical measurements remain null; not current ITP costs or additional official test cases."}
    table["costs"] = previous_costs[:8]
    for key, value in modes.items():
        table["costs"].append(cost_row("tespec " + key.replace(":", " spatial-"), "原生测试执行与自动处理",
            value["mean_execution_wall_seconds"], value["mean_execution_peak_rss_mib"], 0, evaluation_ref["path"]))
    for stage, label in (("agent", "agent 填写证明"), ("coq_compile_and_assumption_audit", "Coq 编译与假设审计"),
                         ("independent_kernel_check", "独立内核检查"), ("total", "ITP 平均合计")):
        value = statistics_itp["stages"][stage]
        table["costs"].append(cost_row("tespec inline ITP", label, value["wall_seconds_mean"],
            value["peak_process_memory_mib_mean"], value["tokens_mean"], rel(BASE / "tespec/statistics.json"),
            "14 次独立执行 ITP 的均值；含所有失败尝试；内存为逐执行峰值均值"))
    for name, setup_stage in shared_setup.items():
        label = "确定性 ABI 库准备" if name == "context_preparation" else "文件系统恢复后证书准备"
        source = transition_ref["path"] if name == "context_preparation" else setup_stage["receipt"]["path"]
        table["costs"].append(cost_row("tespec group setup", label, setup_stage["wall_seconds"], setup_stage["peak_process_rss_kib"] / 1024, setup_stage["tokens"], source, "每组一次；不纳入逐执行 ITP 均值"))
    for result in table["results"]:
        if result["tool"] == "tespec":
            result.update(result="7/7; 28/28 configurations", test_pairs=7, expected_matches=7,
                          executions=28, expected_execution_matches=28)
    table.update(complete=resources_complete, verdict_complete=True, resource_metrics_complete=resources_complete,
        missing_measurements=missing, measurement_environment=MEASUREMENT_ENVIRONMENT, canonical_evaluation=evaluation_ref, latest_native_recheck=latest,
        group_shared_setup=shared_setup, tespec_group_workload=workload,
        itp_statistics=statistics_itp, test_modes={"statistics": rel(BASE / "tespec/statistics.json"), "modes": modes},
        evaluation_notes=["CN 复用源与依赖哈希匹配的主程序验证证据；分配器规约仍是外部假设。QCP 原始 4 个全称 VC 仅在 b1 抽象地址上下文核证；teSpec 测试使用 c6 显式 ABI 上下文。未提供跨上下文等价证书，旧 QCP 证书不作为当前 ABI 谓词的全称证明。",
            "7 个原有合法输入，inline/modular × 空间 SMT OFF/ON 共 28 次执行。14 次 inline 原生 UNKNOWN 各自完成独立 ITP；modular 14 次原生 PASS。",
            "每次执行的全部原始残余 VC 为一个 ITP 任务；实际模型 gpt-6.1-sol，所有证明修复尝试均计入。未改变输入、预期或源程序。",
            "QCP 原始 4 个目标中 1 个 Closed，3 个使用原有 eval_addr_expr 参数；没有新增证明公理。具体 ITP 假设逐证书披露。"],
        coverage_gap=None if resources_complete else rel(BASE / "coverage-gap.json"))
    if strong:
        table["proof_contexts"] = {"tespec": "explicit target ABI, exact original left Dll entailment and parent",
            "qcp": "historical universal verification under legacy abstract-address definitions",
            "relationship": "legacy equivalence not certified; historical QCP certificate is not reused as an ABI-predicate proof"}
        table["evaluation_notes"].append("当前 teSpec 使用显式目标 ABI 重解释 DLL，ITP 直接证明原始左侧 Dll 蕴含，再用固定 or_introl 包装证明父 VC。旧 QCP 全称证书仍只证明旧抽象地址定义；两种定义的等价性未获证明。旧上下文所有尝试并入当前逐执行成本，未增加输入分母。")
    pub.json(BASE / "result-cost.json", table)
    pub.put(BASE / "result-cost.csv", csv_bytes(table["costs"], COST_FIELDS))
    pub.put(BASE / "cases.csv", csv_bytes([{**r, "input": json.dumps(r["input"], separators=(",", ":")),
        "itp_receipt": r.get("itp_receipt", {}).get("path", "")} for r in rows],
        ["case", "variant", "strategy", "spatial_smt", "input", "expected", "raw_status", "final_status", "matches_expected", "wall_seconds", "itp_receipt"]))

    lines = [f"# {GROUP}：结果与成本表", "",
        "完整状态：" + ("已齐全。" if resources_complete else "判定已完成，成本仍有缺口；不计入完整组。"), "",
        "7 对原有合法输入，2 条语言记录；inline/modular × 空间 SMT OFF/ON 共 28 次执行。全部入口 SAT 且执行到出口，最终 28/28 符合原有预期。",
        "14 次 inline 原生 UNKNOWN 各自完成全部原始残余 VC 的 ITP、Coq 编译、假设审计与独立完整内核检查；14 次 modular 原生 PASS。",
        "CN 使用已审计兼容头验证主程序；Fulminate 7/7；QCP 原始 4 个全称 VC 的既有内核证据复用。CN/QCP 的分配器契约仍是外部前提。",
        "", "| 策略 | 空间 SMT | 原生 PASS / UNKNOWN | 最终预期匹配 | 平均原生时间（秒） | 平均峰值 RSS（MiB） |",
        "|---|---|---:|---:|---:|---:|"]
    for value in modes.values():
        counts = value["native_status_counts"]
        lines.append(f"| {value['execution_strategy']} | {value['spatial_smt']} | {counts.get('PASS', 0)} / {counts.get('UNKNOWN', 0)} | 7/7 | {value['mean_execution_wall_seconds']:.6f} | {value['mean_execution_peak_rss_mib']:.4f} |")
    lines += ["", "每次执行的全部原始残余 VC 是一个 ITP 任务；下表 ITP 只展示 14 次任务的均值，包含所有失败尝试。实际模型为 `gpt-6.1-sol`。逐执行收据与总量保存在 JSON。",
        "测量环境：共享主机中观测到其他验证任务同时运行；本任务内部串行。这里的时间不适合作为受控跨版本性能比较。",
        "原生 CLI 已包含执行器和空间 SMT，不再加嵌套时间；agent、Coq/假设审计、独立内核是分开的阶段。RSS 是最大进程峰值，均值由逐执行峰值取平均，不累加内存。ITP 合计行与组成行重叠，不可再相加。", "",
        "| 工具 | 阶段 | 时间（秒） | 峰值进程内存（MiB） | token | 口径 |",
        "|---|---|---:|---:|---:|---|"]
    def display(value):
        return "缺失" if value is None else f"{value:.4f}"
    for cost in table["costs"]:
        lines.append("| " + " | ".join([cost["tool"], cost["stage"], display(cost["wall_seconds"]),
            display(cost["peak_process_memory_mib"]), display(cost["tokens"]), cost["unit"]]) + " |")
    if missing:
        lines += ["", "成本缺口：以下历史失败的时间或 RSS 未完整保留；后续成功重放不能补写，缺项保持 null，已知时间只作为下界。"]
        for item in missing:
            lines.append(f"- execution-{item['execution_index']:02d} / {item['check_attempt']} / {item['stage']}：{item['field']} 缺失，已知 wall={display(item.get('wall_seconds'))} 秒。")
    if strong:
        lines += ["", "证明上下文：当前 teSpec 直接证明显式目标 ABI 下原始左侧 Dll 蕴含及父 VC；旧 QCP 证书仍属于旧抽象地址谓词上下文。两者等价性未获证明，不能将旧 QCP 证书解释成新 ABI 谓词的全称证明。原生费用包含旧、新上下文各一次执行，ITP 费用包含两种上下文所有修复尝试，输入分母不变。"]
    lines += ["", "QCP 原始 4 个目标中 1 个 Closed、3 个使用原有 `eval_addr_expr` 参数；没有新增证明公理。测试 ITP 的允许假设、身份检查及完整审计文本逐收据保留。",
        "旧诊断、修复与先导测量保留在 `result-cost.json` 的 `historical_attempts` 与既有 supplementary 文件中。缺失的历史测量保持 null，不记为 0，不增加正式输入分母。",
        "", "[逐输入与证明引用](evidence/tespec-native.json) · [结果与成本 JSON](result-cost.json) · [成本 CSV](result-cost.csv) · [逐执行 CSV](cases.csv)", ""]
    pub.put(BASE / "result-cost.md", "\n".join(lines))
    index = load(BASE / "index.json")
    if "current_itp_progress" in index:
        index["historical_itp_progress"] = index.pop("current_itp_progress")
    index.pop("current_missing_measurements", None)
    index.update(complete=resources_complete, verdict_complete=True, resource_metrics_complete=resources_complete,
        canonical_evaluation=evaluation_ref, evaluation=evaluation_ref["path"], latest_native_recheck=latest,
        tespec_current_run_status="ALL_EXPECTED_MATCHED" if resources_complete else "VERDICTS_CHECKED_COST_RESOURCE_GAP",
        missing_measurements=missing)
    index["per_tool_evidence"]["tespec"] = evaluation_ref["path"]
    if "latest_tespec_native_retest" in index:
        index["historical_tespec_native_retest"] = index.pop("latest_tespec_native_retest")
    pub.json(BASE / "index.json", index)
    gap = load(BASE / "coverage-gap.json")
    if "current_itp_progress" in gap:
        gap["historical_itp_progress"] = gap.pop("current_itp_progress")
    gap.pop("current_missing_measurements", None)
    for name in ("tespec_current_run", "current_native_retest"):
        if name in gap:
            gap["historical_" + name] = gap.pop(name)
    if "teSpec execution remains blocked" in gap.get("concrete_scope_qualification", ""):
        gap.setdefault("historical_concrete_scope_qualification", gap["concrete_scope_qualification"])
    gap.update(status="RESOLVED" if resources_complete else "VERDICT_COMPLETE_RESOURCE_COST_GAP",
        complete=resources_complete, verdict_complete=True, resource_metrics_complete=resources_complete,
        active_gap=not resources_complete, missing_measurements=missing,
        latest_native_recheck=latest, canonical_evaluation=evaluation_ref,
        concrete_scope_qualification="All 7 original inputs completed 28 teSpec mode executions in the explicit ABI context. Historical QCP verification remains scoped to abstract-address definitions; allocator contracts remain external assumptions.",
        issue_details_scope="Historical attempts only; current verdicts all proved. Any current cost gap is explicitly listed in missing_measurements.",
        tespec_current_run={"status": "ALL_EXPECTED_MATCHED", "executions": 28, "case_pairs": 7,
                            "completed_independent_itp_executions": 14, "pending_itp_executions": 0})
    pub.json(BASE / "coverage-gap.json", gap)
    group_manifest.update(primary_selection_status="CN_COMPAT_VERIFIED_QCP_LEGACY_KERNEL_CHECKED_TESPEC_ABI_VERDICTS_CHECKED" +
        ("" if resources_complete else "_COST_INCOMPLETE"),
        current_coverage_gap=None if resources_complete else rel(BASE / "coverage-gap.json"),
        canonical_evaluation=evaluation_ref, test_modes_statistics=rel(BASE / "tespec/statistics.json"),
        evaluation_notes=table["evaluation_notes"] + ([] if resources_complete else ["历史 ITP 失败或中断尝试的时间、RSS 有缺项，判定完成但不计完整组。 "]))
    pub.json(group_manifest_path, group_manifest)
    replace_progress_references(pub, progress_replacement)
    return pub, evaluation, index


def update_global(evaluation, evaluation_ref):
    """Called only after the group has passed the explicit full/partial audit."""
    pub, complete = Publication(), evaluation["complete"]
    path = ROOT / "benchmark/results/group-result-cost-index.json"
    table = load(path)
    target = [entry for entry in table["groups"] if entry["program_group"] == GROUP]
    need(len(target) == 1, "Missing/ambiguous group index row")
    target[0].update(complete=complete, verdict_complete=True,
        resource_metrics_complete=evaluation["resource_metrics_complete"], canonical_evaluation=evaluation_ref)
    completed = [entry for entry in table["groups"] if entry["complete"]]
    count, pairs = len(completed), 0
    for entry in completed:
        cost = load(ROOT / entry["json"])
        need(cost["complete"] is True, "Index/table complete mismatch")
        tespec = next(row for row in cost["results"] if row["tool"] == "tespec")
        pairs += tespec["test_pairs"]
    need((count, pairs) == ((23, 908) if complete else (22, 901)),
         "Other global coverage changed; review before publishing totals")
    table["complete_groups"] = count
    summary = table.setdefault("current_completion_summary", {})
    if "next_group_current_itp_progress" in summary:
        summary["last_group_historical_itp_progress"] = summary.pop("next_group_current_itp_progress")
    historical_progress = load(BASE / "result-cost.json").get("historical_itp_progress")
    if historical_progress is not None:
        disk_ref(ROOT, historical_progress)
        summary["last_group_historical_itp_progress"] = historical_progress
    summary.update(complete_groups=count, groups_total=45, incomplete_groups=45-count,
        complete_group_case_pairs=pairs,
        scope="Published complete four-tool result/proof/cost evaluations. A proved verdict with missing attempt wall time or RSS is not a complete group. Existing 22 groups were not rerun by this publication.",
        last_evaluated_group=GROUP, last_group_verdict_complete=True,
        last_group_resource_metrics_complete=evaluation["resource_metrics_complete"],
        current_instruction="Continue user-authorized group 23 evaluation using gpt-6.1-sol; prior organize-only pause was lifted.")
    incomplete = [entry for entry in table["groups"] if not entry["complete"]]
    summary["next_incomplete_group"] = incomplete[0]["program_group"] if incomplete else None
    summary["next_group_pending_itp_executions"] = 0 if not complete else None
    summary["last_group_evidence"] = evaluation_ref
    summary["last_group_missing_measurements"] = evaluation["missing_measurements"]
    if complete:
        summary.pop("next_group_current_native_evidence", None)
    else:
        summary["next_group_current_native_evidence"] = evaluation_ref["path"]
    pub.json(path, table)
    md_path = path.with_suffix(".md")
    markdown = md_path.read_text()
    prefix = f"| [{GROUP}]({GROUP}/result-cost.md) | "
    candidates = [line for line in markdown.splitlines() if line.startswith(prefix)]
    need(len(candidates) == 1 and candidates[0] in [prefix + value + " |" for value in ("待补齐", "判定已完成；成本缺 RSS", "判定已完成；成本有缺项")],
         "Global display row changed")
    pub.put(md_path, markdown.replace(candidates[0], prefix + ("已齐全" if complete else "判定已完成；成本有缺项") + " |"))
    path = ROOT / "benchmark/results/index.json"
    index = load(path)
    index.update(complete_current_groups=count, pending_current_groups=45-count,
        coverage=f"{count}/45 groups have complete current result/proof/cost tables ({pairs} input pairs). The singleton current verdicts match all 28 configurations; missing failed/interrupted-attempt wall time or RSS, if present, does not count as complete.")
    if not any(item["group"] == GROUP for item in index["current_groups"]):
        index["current_groups"].append({"group": GROUP, "index": rel(BASE / "index.json")})
    index["current_singleton_summary"] = {"evidence": evaluation_ref, "case_pairs": 7, "executions": 28,
        "complete": complete, "verdict_complete": True, "resource_metrics_complete": evaluation["resource_metrics_complete"]}
    pub.json(path, index)
    path = ROOT / "benchmark/results/tespec-unexpected/index.json"
    ledger = load(path)
    ledger.setdefault("current_group_rechecks", {})[GROUP] = {
        "evidence": evaluation_ref["path"], "sha256": evaluation_ref["sha256"],
        "scope": "Current original seven inputs across inline/modular OFF/ON. Older aggregate ledger counts retain their historical scan scope.",
        "case_pairs": 7, "executions": 28, "unexpected_executions": 0, "new_cases": 0,
        "raw_status_counts": evaluation["raw_status_counts"], "final_status_counts": {"PASS": 28},
        "itp": "14_INDEPENDENT_KERNEL_CHECKED", "verdict_complete": True,
        "resource_metrics_complete": evaluation["resource_metrics_complete"], "complete": complete,
        "missing_measurements": evaluation["missing_measurements"],
        "reason": "Original inline Dll residuals proved separately for each execution; modular was native PASS. No expected values changed."}
    pub.json(path, ledger)
    return pub


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--itp-root", required=True, type=Path)
    parser.add_argument("--model-root", required=True, type=Path)
    parser.add_argument("--native-results", required=True, type=Path)
    parser.add_argument("--task-overrides", type=Path, help="Exact native recovery task overrides; original 14-task inventory stays immutable")
    parser.add_argument("--apply", action="store_true", help="Write, audit and then update global indices; otherwise read-only preflight")
    parser.add_argument("--allow-partial", action="store_true", help="Explicitly publish proved verdicts with disclosed failed-attempt cost gaps; never count the group complete")
    args = parser.parse_args()
    pub, evaluation, index = prepare(args.itp_root.resolve(), args.model_root.resolve(), args.native_results.resolve(), args.task_overrides.resolve() if args.task_overrides else None)
    audit_prepared_publication(pub, index, allow_partial=not args.apply or args.allow_partial)
    if not args.apply:
        print(json.dumps({"preflight": "PASS", "files_planned": len(pub.files), "writes": 0,
                          "verdict_complete": True, "resource_metrics_complete": evaluation["resource_metrics_complete"],
                          "missing_measurements": evaluation["missing_measurements"]}, ensure_ascii=False))
        return
    need(evaluation["complete"] or args.allow_partial,
         "All verdicts proved but historical attempt time/RSS is missing; default publication refused. --allow-partial retains this gap and does not increase complete groups.")
    before = pub.apply()
    globals_before, globals_pub = None, None
    try:
        audit_canonical_group(GROUP, ROOT, index, allow_partial=args.allow_partial)
        globals_pub = update_global(evaluation, index["canonical_evaluation"])
        globals_before = globals_pub.apply()
        for path, content in globals_pub.files.items():
            need(path.read_bytes() == content, "Global publication changed after write: " + str(path))
    except BaseException:
        if globals_before is not None:
            globals_pub.rollback(globals_before)
        pub.rollback(before)
        raise
    print(json.dumps({"published": GROUP, "complete": evaluation["complete"], "verdict_complete": True,
        "resource_metrics_complete": evaluation["resource_metrics_complete"], "case_pairs": 7, "executions": 28,
        "independent_itp_tasks": 14, "complete_groups": 23 if evaluation["complete"] else 22,
        "complete_group_case_pairs": 908 if evaluation["complete"] else 901}, ensure_ascii=False))


if __name__ == "__main__":
    main()
