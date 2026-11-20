"""Publish and re-audit per-execution source replays from the proof controller."""
import hashlib
import json
import os
from tempfile import NamedTemporaryFile
from pathlib import Path
import re

from validate_current_group_evidence import aggregate, audit_coverage, digest, finite, identity_ref, load, names_from_audit, need, ref, sha
from spectest.certificates import check_candidate_commands, coverage_source, goal_interface
from spectest.proof_reuse import dependency_ids


def link(root, path):
    path = Path(path).resolve()
    return {"path": str(path.relative_to(root)), "sha256": sha(path)}


def persist(path, data, root):
    path.parent.mkdir(parents=True, exist_ok=True)
    if not path.exists():
        with NamedTemporaryFile(dir=path.parent, delete=False) as temp:
            pending = Path(temp.name)
            try:
                temp.write(data)
                temp.flush()
                os.link(pending, path)
            except FileExistsError:
                pass
            finally:
                pending.unlink(missing_ok=True)
    need(path.read_bytes() == data, "Two proof artifacts claim the same identity")
    return link(root, path)


def canonical(value):
    return json.dumps(value, ensure_ascii=False, sort_keys=True, separators=(",", ":")).encode()


def submit_json(path, value, root):
    data = canonical(value) + b"\n"
    address = hashlib.sha256(data).hexdigest()
    return persist(path.parent / "current" / address / path.name, data, root)


def captured(root, folder, path):
    path = Path(path)
    return persist(folder / "proof-objects" / sha(path) / path.name, path.read_bytes(), root)


def source_candidate(root, origin, evidence):
    """Reconstruct the exact proof text, including the archived helper when present."""
    need(origin.get("schema") == "tespec-current-proof/v1" and origin.get("kind") == "test"
         and origin.get("coverage_style") == "direct-original-targets" and origin.get("status") == "PASS",
         "Expected a published proof of directly named original goals")
    goal = ref(root, origin["goal"])
    candidate = ref(root, origin["candidate"])
    audit_coverage(origin, goal, candidate, {})
    inputs, expected = origin["input"], dict(goal_interface(goal.read_text()))
    need(len(inputs) == 1 and origin["native_input"] == evidence["native_input"]
         and origin["input"] == evidence["input"] and origin["source"] == evidence["source"]
         and origin["goal"]["sha256"] == evidence["goal"]["sha256"]
         and origin["logical_context"] == evidence["logical_context"]
         and origin["targets"] == evidence["targets"], "Archived proof context differs from this execution")
    ref(root, origin["source"])
    context = load(ref(root, evidence["logical_context"]))
    dependency_names = {dep["module"]: dep["sha256"] for dep in context["coq_dependencies"]}
    current_deps = {ref(root, dep).stem: dep["sha256"] for dep in evidence["dependencies"]}
    need(current_deps == dependency_names, "Current certificate dependencies differ from the original context")
    for dep in context["runtime_dependencies"]:
        for name, key in (("source", "sha256"), ("compiled", "compiled_sha256")):
            archived_path = Path(dep[name])
            parts = archived_path.parts
            need(parts.count("runtime") == 1 and ".." not in parts, "Unexpected runtime dependency path")
            target = (root / Path(*parts[parts.index("runtime"):])).resolve()
            need(target.is_relative_to(root / "runtime"), "Unexpected runtime dependency")
            identity_ref(root, {"path": str(target), "sha256": dep[key]})
    helper = None
    for dep in origin["dependencies"]:
        path = ref(root, dep)
        if path.stem in current_deps:
            need(dep["sha256"] == current_deps[path.stem], "Archived dependency changed")
        else:
            need(path.name == "FiniteEntryHeap.v" and helper is None, "Unsupported proof helper")
            helper = path
    code = candidate.read_text()
    if helper is not None:
        header = "From SimpleC.Verification Require Import VCPrelude.\nRequire Import DLLSupplement.\n"
        old_import = "Require Import ExecutionGoal DLLSupplement FiniteEntryHeap."
        need(helper.read_text().startswith(header) and code.count(old_import) == 1
             and code.count("FiniteEntryHeap") == 1, "Unrecognized archived helper imports")
        check_candidate_commands(helper.read_text())
        embedded = "Module FiniteEntryHeap.\n" + helper.read_text()[len(header):] + "\nEnd FiniteEntryHeap.\n\n"
        code = header + "Require Import Goal.\n\n" + embedded + code.replace(old_import, "Import FiniteEntryHeap.")
    code = re.sub(r"\bExecutionGoal\b", "Goal", code)
    definitions = [f"Definition {name} : Goal.{expected[name]} := {origin['target_theorems'][name]}."
                   for name in evidence["targets"]]
    return code + "\nModule Proofs.\n" + "\n".join(definitions) + "\nEnd Proofs.\n"


def check_stages(measures, ids, p, check, seen_checks):
    need(len(ids) == len(set(ids)) and bool(ids), "Invalid replay cost inventory")
    need(check["measurements_sha256"] == hashlib.sha256(canonical([measures[mid] for mid in ids])).hexdigest(),
         "Costs differ from the independently measured checker stages")
    size = len(ids)
    expected_labels = (["candidate_precheck"] if measures[ids[0]]["label"] == "candidate_precheck" else [])
    expected_labels += ["version"]
    expected_labels += ["compile_dependencies_" + Path(d["path"]).name for d in p["dependencies"]]
    expected_labels += ["compile_Goal.v", "compile_Candidate.v", "compile_Coverage.v", "compile_Assumptions.v", "kernel_replay"]
    need(size == len(expected_labels), "Incomplete replay stage inventory")
    for mid, label in zip(ids, expected_labels):
        m = measures[mid]
        need("measurement:" + mid not in seen_checks, "Duplicate per-execution checker measurement")
        seen_checks.add("measurement:" + mid)
        need(m["tool"] == "tespec" and m["label"] == label and m["stage"] == ("kernel" if label == "kernel_replay" else "coq")
             and m["exit_code"] == 0 and m["tokens"] == 0 and finite(m["wall_seconds"])
             and finite(m["max_process_rss_kib"], True), "Invalid replay stage cost")
        need(check["source_logs"].get(label) == m["combined_output_sha256"] and digest(m["combined_output_sha256"]),
             "Checker log identity mismatch")
        cmd = m["command"]
        if label == "version":
            need(cmd[-2:] == ["coqc", "--version"], "Wrong version command")
        elif label == "kernel_replay":
            need("coqchk" in cmd and cmd[-1] == "Coverage" and not any(x.startswith(("-admit", "-norec")) for x in cmd),
                 "Missing full independent kernel check of Coverage")
        elif label.startswith("compile_"):
            target = label.removeprefix("compile_").removeprefix("dependencies_")
            need("coqc" in cmd and Path(cmd[-1]).name == target, "Missing original Coq compilation stage")
    need(set(check["source_logs"]) == set(expected_labels), "Stray checker log inventory")


def audit_replayed_certificate(root, p, measures, seen_checks):
    need(p["kind"] == "test" and p["status"] == "PASS", "Wrong source-replay scope")
    [attempt] = p["attempts"]
    need(attempt["attempt"] == p["selected_attempt"] == 1 and "model" not in attempt, "Model-free proof attempt required")
    replay = attempt["source_replay"]
    source = load(ref(root, replay["source_certificate"]))
    need(replay["source_candidate_sha256"] == source["candidate"]["sha256"], "Wrong archived candidate")
    goal = ref(root, p["goal"])
    candidate = ref(root, p["candidate"])
    need(candidate.read_text() == source_candidate(root, source, p), "Candidate differs from exact archived proof adaptation")
    check_candidate_commands(candidate.read_text())
    targets = p["targets"]
    inventory = dict(goal_interface(goal.read_text()))
    need(len(targets) == 1 and targets[0] in inventory, "Expected one original residual goal")
    coverage = ref(root, p["proof_files"]["coverage"])
    need(coverage.read_text() == coverage_source([(targets[0], inventory[targets[0]])], partial=True), "Wrong checked coverage")
    audit = ref(root, p["proof_files"]["audit"])
    expected_audit = "Require Import Coverage.\nSet Printing Width 1000000.\nPrint Assumptions Coverage.Checked." + targets[0] + ".\n"
    need(audit.read_text() == expected_audit, "Wrong per-target assumption-audit source")
    [check_ref] = attempt["checks"]
    check_path = ref(root, check_ref)
    need(sha(check_path) not in seen_checks, "Reused proof checker receipt")
    seen_checks.add(sha(check_path))
    check = load(check_path)
    need(check["schema"] == "tespec-source-replay-check/v1" and digest(check["source_receipt_sha256"])
         and check["status"] == "PASS" and check["kernel_replay_mode"] == "full"
         and check["execution_id"] == p["execution_id"] and check["candidate_sha256"] == p["candidate"]["sha256"]
         and check["original_goal_sha256"] == p["goal"]["sha256"] and check["selected_goals"] == targets
         and check["native_receipt_sha256"] == p["native_receipt_sha256"] and check["report_sha256"] == p["report_sha256"]
         and check["measurements"] == p["measurement_ids"], "Replay checker binding differs")
    receipt_key = "source_receipt:" + check["source_receipt_sha256"]
    need(receipt_key not in seen_checks, "One original checker receipt used twice")
    seen_checks.add(receipt_key)
    check_stages(measures, check["measurements"], p, check, seen_checks)
    emitted = check["assumption_audit"]
    need(hashlib.sha256(emitted.encode()).hexdigest() == check["source_logs"]["compile_Assumptions.v"]
         and emitted.count("Closed under the global context") == 1 and "Axioms:" not in emitted
         and not names_from_audit(emitted) and p["globally_closed"] is True,
         "Missing actual closed assumption audit")
    diff = p["assumption_differential"]
    need(diff["statement_baseline"] == source["assumption_differential"] and diff["checked_term"] == "Coverage.Checked." + targets[0]
         and diff["additional_proof_assumptions"] == [], "Incorrect assumption differential")
    baseline = load(ref(root, diff["statement_baseline"]))
    originals = [v for v in baseline["targets"].values() if v["original_vc"]]
    need(len(originals) == 1 and originals[0]["statement"]["qualified_term"] == goal.stem + "." + inventory[targets[0]]
         and originals[0]["statement"]["raw_block"].strip() == "Closed under the global context",
         "Missing archived statement audit for the identical original Goal")
    need(aggregate(measures, p["measurement_ids"]) == p["metrics"] and p["metrics"]["model_calls"] == 0,
         "Incorrect source replay cost")
    return p


def publish_replayed_certificate(root, execution_id, automatic_report, checked_report, source_certificate, *, evidence_dir=None):
    """Compact one completed source replay and return (proof reference, measured stages)."""
    root = Path(root).resolve()
    folder = Path(evidence_dir).resolve() if evidence_dir else root / "benchmark/results/dll_add/evidence"
    need(folder.is_relative_to(root), "Proof evidence must be published within the selected repository")
    auto_path, final_path = Path(automatic_report), Path(checked_report)
    source_path = (ref(root, source_certificate) if isinstance(source_certificate, dict)
                   else (root / source_certificate).resolve())
    old, auto, final = load(source_path), load(auto_path), load(final_path)
    [case], [proved] = auto["results"], final["results"]
    stage = final_path.parent
    run_manifest = stage / "run-manifest.json"
    request = load(run_manifest)
    [entry] = request["certificates"]
    bundle_path = Path(entry["manifest"])
    bundle = load(bundle_path)
    work = bundle_path.parent
    raw_path = Path(case["stdout"])
    raw = load(raw_path)
    spec = raw["spec_test"]
    need(raw["functionName"] == auto["function"] and spec["completed"] is True
         and raw["preconditions"] == case["preconditions"] and spec["vc_results"] == case["vc_results"]
         and spec["target_layout"] == case["target_layout"] and spec["execution_strategy"] == case["execution_strategy"],
         "Native executor receipt differs from the automatic report")
    goal_path = Path(case["vc"]["files"]["goal"])
    proof = final["proof_completion"]
    telemetry = proof["agent"]
    [attempt], [audited] = telemetry["attempts"], proof["certificates"]
    checker_file = work / "certificate-report.json"
    check = load(checker_file)
    targets = entry["selected_decision_roots"]
    need(execution_id == case["execution_strategy"] + "-" + ("on" if auto["vc_policy"].get("spatial_smt", {}).get("enabled") else "off")
         + "-" + case["id"] and re.fullmatch(r"[\w-]+", execution_id), "Wrong execution ID/strategy/mode")
    need(proved["evidence"]["kernel_checked_goals"] == targets == case["residual_vcs"] == bundle["selected_goals"]
         and len(targets) == 1 and auto["itp_vcs"][0]["goals"] == targets, "Unexpected residual goal scope")
    need(proof["status"] == "CHECKED" and telemetry["agent_invocations"] == telemetry["tokens"] == 0
         and attempt["source"] in {"cache", "published"} and "agent" not in attempt and attempt["check"] == check
         and audited["certificate"] == check, "Expected one successful measured model-free attempt")
    need(case["status"] == case["precondition_result"] == "UNKNOWN" and case["execution_completed"] is True
         and proved["status"] == "PASS" and proved["precondition_result"] == "SAT"
         and proved["evidence"]["certificate"] == "CHECKED_DECISION_VCS"
         and case["id"] == proved["id"] == check["case_id"] == entry["case_id"] == audited["case_id"] == attempt["case_id"],
         "Incomplete or unrelated controller success")
    need(load(stage / "automatic.json") == auto and sha(stage / "automatic.json") == request["automatic_sha256"]
         == proof["automatic_report_sha256"] and proof["run_manifest_sha256"] == sha(run_manifest)
         and check["manifest_sha256"] == sha(bundle_path) == entry["manifest_sha256"]
         and sha(Path(case["vc"]["manifest"])) == bundle["original_manifest_sha256"]
         and check["original_goal_sha256"] == sha(goal_path) == sha(work / "Goal.v") == old["goal"]["sha256"],
         "Automatic report, original goal or proof manifest was substituted")
    need(check["status"] == "PASS" and check["polarity"] == "positive" and check["vc_status"] == check["proof_status"] == "VALID"
         and check["kernel_replay_mode"] == "full" and check["assumptions_audited_goals"] == 1
         and not any(check[k] for k in ("assumptions", "unexpected_assumptions", "unsupported_assumption_records")),
         "Replay lacks a fully audited original positive goal")
    input_data = {"args": case["arguments"], "values": case["bindings"]}
    if case.get("type_bindings"):
        input_data["type_bindings"] = case["type_bindings"]
    need(source_path.is_relative_to(root) and old["native_input"] == input_data
         and old["input"] == [dict(input_data, id=case["id"])] and Path(auto["source"]).resolve() == ref(root, old["source"])
         and sha(Path(auto["source"])) == auto["provenance"]["source_sha256"], "Source or native input differs")
    if attempt["source"] == "published":
        need(source_path == Path(attempt["origin"]).resolve(), "Published replay came from another source")
    current = load(Path(case["vc"]["manifest"]))
    context = load(ref(root, old["logical_context"]))
    need(check["target_layout"] == bundle["target_layout"] == context["target_layout"] == current["target_layout"]
         and all(dependency_ids(current[k]) == dependency_ids(context[k]) for k in ("coq_dependencies", "runtime_dependencies")),
         "Target layout or original dependency closure changed")
    by_name = {Path(d["path"]).stem: d for d in old["dependencies"]}
    deps = [by_name[d["module"]] for d in bundle["dependencies"]]
    for frozen, actual in zip(bundle["dependencies"], deps):
        need(frozen["sha256"] == sha(ref(root, actual)) == sha(work / frozen["file"]), "Checker staged another dependency")
    p = {"schema": "tespec-current-proof/v1", "coverage_style": "controller-selected-targets", "status": "PASS", "kind": "test",
         "execution_id": execution_id, "targets": targets, "goal": old["goal"], "source": old["source"],
         "logical_context": old["logical_context"], "dependencies": deps, "native_input": input_data,
         "input": [dict(input_data, id=case["id"])], "native_receipt_sha256": sha(raw_path),
         "report_sha256": sha(auto_path), "native_vc_manifest_sha256": bundle["original_manifest_sha256"],
         "selected_attempt": 1, "globally_closed": True}
    need((work / "Candidate.v").read_text() == source_candidate(root, old, p)
         and sha(work / "Candidate.v") == check["candidate_sha256"], "Replayed candidate is not derived from source")
    p["candidate"] = captured(root, folder, work / "Candidate.v")
    p["proof_files"] = {}
    for key, name in [("audit", "Assumptions.v"), ("coverage", "Coverage.v")]:
        need(sha(work / name) == bundle["immutable_sha256"][name], "Coverage/audit source changed")
        p["proof_files"][key] = captured(root, folder, work / name)
    measurements, logs = [], {}
    for number, s in enumerate(check["stages"], 1):
        label = s["stage"]
        log_path = Path(s["log"])
        need(log_path.resolve() == (work / (label + ".log")).resolve(), "Stage belongs to a different execution")
        logs[label] = sha(log_path)
        metrics = s["resources"]
        need(load(work / (label + ".resources.json")) == metrics, "Process resource receipt changed")
        measurements.append({"id": f"tespec/current/{execution_id}/check/{number}", "tool": "tespec", "label": label,
                             "stage": "kernel" if label == "kernel_replay" else "coq", "command": s["command"],
                             "exit_code": s["exit_code"], "wall_seconds": s["wall_seconds"], "tokens": 0,
                             "max_process_rss_kib": metrics["max_process_rss_kib"], "combined_output_sha256": logs[label]})
    ids = [m["id"] for m in measurements]
    evidence = {"schema": "tespec-source-replay-check/v1", "source_receipt_sha256": sha(checker_file),
                "execution_id": execution_id, "selected_goals": targets, "status": "PASS", "kernel_replay_mode": "full",
                "source_logs": logs, "candidate_sha256": check["candidate_sha256"], "original_goal_sha256": sha(goal_path),
                "native_receipt_sha256": p["native_receipt_sha256"], "report_sha256": p["report_sha256"],
                "controller_manifest_sha256": sha(bundle_path), "controller_final_report_sha256": sha(final_path),
                "checker_wall_seconds": check["duration_seconds"],
                "measurements_sha256": hashlib.sha256(canonical(measurements)).hexdigest(),
                "assumption_audit": (work / "compile_Assumptions.v.log").read_text(), "measurements": ids}
    check_ref = submit_json(folder / "checks" / ("current-" + execution_id + ".json"), evidence, root)
    p["attempts"] = [{"attempt": 1, "checks": [check_ref], "source_replay": {
        "source_certificate": link(root, source_path), "source_candidate_sha256": old["candidate"]["sha256"]}}]
    p["assumption_differential"] = {"statement_baseline": old["assumption_differential"],
                                   "checked_term": "Coverage.Checked." + targets[0], "additional_proof_assumptions": []}
    measures = {m["id"]: m for m in measurements}
    p["measurement_ids"] = ids
    p["metrics"] = aggregate(measures, ids)
    audit_replayed_certificate(root, p, measures, set())
    return submit_json(folder / "proofs" / ("current-" + execution_id + ".json"), p, root), measurements
