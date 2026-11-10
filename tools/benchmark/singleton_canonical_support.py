"""Read-only singleton strong-proof/context-cost bindings; never runs a prover."""
from __future__ import annotations
import copy
import hashlib
import json
from pathlib import Path
from singleton_strong_support import MODULES, binding_layout, strong_template, verify_candidate

PROFILE = "singleton-strong-left-abi/v1"
SUPPORT_SHA256 = "cdab426394603d6d147adcd89f251030a0987894b3387b4b1d1378a9957d54be"
SUPPORT_PATH = "tools/benchmark/singleton_strong_support.py"


def canonical_sha(value):
    return hashlib.sha256(json.dumps(value, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def need(condition, message):
    if not condition:
        raise ValueError(message)


def execution_key(row):
    return canonical_sha({k: row[k] for k in ("case", "variant", "strategy", "spatial_smt", "input", "source_sha256")})


def verify_attestation(value, goal_bytes, candidate_bytes, context, manifest_sha, report_sha):
    """Independently reconstruct the stronger statement and immutable parent wrapper."""
    candidate = verify_candidate(candidate_bytes, goal_bytes)
    template = strong_template(goal_bytes)[2]
    expected = {"schema": "tespec-singleton-strong-left-attestation/v1", "status": "KERNEL_CHECKED",
        "template": template, "proof_body_sha256": candidate["proof_body_sha256"],
        "candidate_sha256": candidate["candidate_sha256"], "abi_context_sha256": canonical_sha(context),
        "certificate_manifest_sha256": manifest_sha, "certificate_report_sha256": report_sha,
        "full_kernel": True, "parent_construction": "exact (or_introl original_return_entailment)"}
    need(value == expected, "Strong-left attestation differs from original Goal, ABI context or checked Candidate")
    return candidate


def audit_strong_binding(root, receipt, row, final, evidence_reader=None):
    """Durable source/statement audit; temporary staged paths need not still exist."""
    from validate_canonical_group import ref as disk_ref, load, digest
    ref = evidence_reader or disk_ref
    need(receipt.get("proof_profile") == PROFILE, "Missing singleton strong-left proof profile")
    need(digest(ref(root, receipt["support"])) == SUPPORT_SHA256 == digest(root / SUPPORT_PATH), "Strong binding implementation differs from executed checker")
    original_path = ref(root, receipt["original_manifest"])
    original = load(original_path)
    need(digest(original_path) == receipt["original_manifest_sha256"], "Original native manifest changed")
    need(original["immutable_sha256"]["goal"] == receipt["original_goal_sha256"] and original["residual_goals"] == receipt["selected_goals"], "Native manifest and original residual Goal differ")
    manifest_path = ref(root, receipt["certificate_manifest"])
    manifest = load(manifest_path)
    need(manifest["original_manifest_sha256"] == digest(original_path) and manifest["original_goal_sha256"] == receipt["original_goal_sha256"], "Certificate manifest no longer binds original native export")
    need(manifest["target_layout"] == original["target_layout"] == final.get("target_layout"), "Certificate target layout differs from native ABI")
    need(Path(manifest["runtime"]).resolve() == (Path(original["qcip_root"]) / "SeparationLogic").resolve(), "Native and certificate runtime roots differ")
    need(final.get("manifest_sha256") == digest(manifest_path) and manifest["immutable_sha256"]["Goal.v"] == receipt["original_goal_sha256"], "Kernel certificate does not bind retained manifest/Goal")
    context = binding_layout(receipt["abi_context"]["bundle"], original["target_layout"])
    need(context == receipt["abi_context"], "Recorded ABI context differs from exact layout-library transformation")
    native_deps = original.get("coq_dependencies", [])
    need([d["module"] for d in native_deps] == MODULES, "Native manifest does not bind all three ABI dependencies in order")
    proof_deps = receipt["dependencies"]
    need([d["module"] for d in proof_deps] == MODULES, "Retained strong proof dependencies differ")
    need([(d["module"], d["sha256"]) for d in manifest["dependencies"]] == [(d["module"], d["sha256"]) for d in proof_deps], "Checked certificate dependencies differ from retained objects")
    for native_dep, proof_dep in zip(native_deps, proof_deps):
        module = native_dep["module"]
        expected_source = (Path(context["bundle"]) / (module + ".v")).resolve()
        need(Path(native_dep["source"]).resolve() == expected_source, "Native ABI dependency source differs")
        need(native_dep["sha256"] == proof_dep["sha256"] == digest(ref(root, proof_dep)) == context["modules"][module], "ABI dependency hashes differ")
    goal, candidate = ref(root, receipt["goal"]).read_bytes(), ref(root, receipt["candidate"]).read_bytes()
    binding = verify_attestation(receipt["strong_left_attestation"], goal, candidate, context,
        digest(manifest_path), final["certificate_report_sha256"])
    need(receipt["strong_left_attestation_sha256"] == canonical_sha(receipt["strong_left_attestation"]), "Strong attestation checksum differs")
    need(final["strong_left_attestation"] == receipt["strong_left_attestation"] and final["strong_left_attestation_sha256"] == receipt["strong_left_attestation_sha256"], "Selected check does not attest the same strong proof")
    need(final.get("support_sha256") == SUPPORT_SHA256 and final.get("binding", {}).get("strong_left") == binding, "Selected checker strong candidate binding differs")
    for model in receipt["model_attempts"]:
        need(set(model["locked_goal_and_helper_sha256"]) == {"Goal.v", *(module + ".v" for module in MODULES)}, "Strong model locked-input inventory differs")
    for check in receipt["checks"]:
        if check.get("schema") == "tespec-singleton-infrastructure-interruption/v1":
            # audit_itp independently validates this raw recovery evidence. It is never selected as proof.
            continue
        need(check.get("support_sha256") == SUPPORT_SHA256, "Checker used a different strong-profile policy")
        b = check.get("binding", {})
        need(b.get("abi_context") == context and b.get("original_goal_sha256") == receipt["original_goal_sha256"] and b.get("original_manifest_sha256") == digest(original_path), "Strong check used another native proof context")
        need(b.get("external_definitions") == context["modules"], "Strong check dependency binding differs")
        for key in ("case", "strategy", "spatial_smt", "input", "source_sha256"):
            need(b.get(key) == row[key], "Strong check execution binding differs: " + key)
        need(b.get("precondition_result") == "SAT" and b.get("execution_completed") is True, "Strong check lacks completed native execution")
        need(b.get("original_residual_vcs") == receipt["selected_goals"], "Strong check omits original residual VC")
        need(check.get("certificate_manifest_sha256") == digest(manifest_path), "Check certificate manifest differs")
        strong = b.get("strong_left", {})
        need(all(strong.get(k) == v for k, v in strong_template(goal)[2].items()) and strong.get("candidate_sha256") == check["candidate_sha256"], "Attempt changes strong statement or fixed wrapper")
    need(receipt["selected_goals"] == ["proof_of_singleton_return_wit_1"], "Unexpected strong-profile obligation inventory")
    return binding


def combine_metrics(values):
    """Sum disjoint attempts; any missing historical peak remains incomplete."""
    need(bool(values), "Missing context costs")
    result = {}
    for stage in ("agent", "coq_compile_and_assumption_audit", "independent_kernel_check", "total"):
        parts = [value[stage] for value in values]
        time_complete = all(p["wall_seconds"] is not None for p in parts)
        merged = {"wall_seconds": sum(p["wall_seconds"] for p in parts) if time_complete else None, "tokens": sum(p["tokens"] for p in parts)}
        if not time_complete:
            merged.update(wall_time_complete=False, known_wall_seconds_lower_bound=sum(p.get("known_wall_seconds_lower_bound", p.get("wall_seconds")) or 0 for p in parts))
        for cpu in ("cpu_user_seconds_observed", "cpu_system_seconds_observed"):
            if any(cpu in p for p in parts):
                merged[cpu] = sum(p.get(cpu, 0) for p in parts)
        if any("measurement_scope_complete" in p for p in parts):
            merged["measurement_scope_complete"] = all(p.get("measurement_scope_complete", True) for p in parts)
        peak_key = "peak_process_resident_bytes" if stage in ("agent", "total") else "peak_process_rss_kib"
        lower_key = "observed_peak_rss_lower_bound_bytes" if stage == "total" else "observed_peak_rss_lower_bound_kib"
        peaks = [p[peak_key] for p in parts]
        complete = all(p is not None for p in peaks)
        merged[peak_key] = max(peaks) if complete else None
        if stage != "agent":
            known = [p.get(lower_key) for p in parts if p.get(lower_key) is not None]
            merged[lower_key] = max(known) if known else None
            merged["resource_metrics_complete"] = complete and time_complete
        for count in ("model_calls", "check_attempts", "subprocesses"):
            if count in parts[0]:
                merged[count] = sum(p[count] for p in parts)
        result[stage] = merged
    return result


def legacy_costs(root, refs, row):
    """Audit legacy parent proofs for costs only, never as ABI proof evidence."""
    from validate_canonical_group import audit_itp, ref, load
    need(isinstance(refs, list) and len(refs) <= 1, "Singleton has at most one legacy execution receipt")
    values, missing = [], []
    for item in refs:
        old = load(ref(root, item))
        need(not old.get("proof_profile") and not old.get("legacy_cost_receipts"), "Legacy cost reference must not recurse into active proofs")
        oldrow = {**row, "vc_sha256": {"goal": old["original_goal_sha256"]}, "residual_vcs": old["selected_goals"]}
        audited = audit_itp(root, item, oldrow, allow_partial=True)
        need(audited["input"] == row["input"], "Legacy cost input differs")
        values.append(audited["metrics"])
        missing.extend({**m, "proof_context": "legacy", "cost_receipt_sha256": item["sha256"]} for m in audited["missing_measurements"])
    return values, missing


def native_cost(row):
    stages = row.get("native_attempts")
    if stages is None:
        return row["wall_seconds"], row["resources"]["max_process_rss_kib"]
    need(isinstance(stages, list) and len(stages) in (2, 3), "Expected legacy/ABI native attempts and at most one measured recovery")
    return sum(s["wall_seconds"] for s in stages), max(s["peak_process_rss_kib"] for s in stages)


def native_stage(row):
    return {"wall_seconds": row["wall_seconds"], "peak_process_rss_kib": row["resources"]["max_process_rss_kib"],
        "tokens": row["tokens"], "model_calls": row["model_calls"],
        "command_sha256": canonical_sha(row["command"]), "report_sha256": row["report_sha256"]}


def audit_transition(root, transition_ref, rows, native_sha, abi_context):
    """Bind all old costs to the same 28 executions, with no case duplication."""
    from validate_canonical_group import ref, load, number
    transition = load(ref(root, transition_ref))
    need(transition.get("schema") == "tespec-proof-context-transition/v1" and transition.get("group") == "Dbl_Linked_List__singleton", "Wrong context transition")
    need(transition["active_native_results_sha256"] == native_sha, "Context transition uses another native run")
    legacy_native = load(ref(root, transition["legacy_native"]))
    legacy_progress = load(ref(root, transition["legacy_itp_progress"]))
    ref(root, transition["semantic_review"])
    need(legacy_native["original_native_results_sha256"] == transition["legacy_native_results_sha256"] == legacy_progress["native_results_sha256"], "Legacy context snapshots differ")
    for name in ("legacy_context", "active_context"):
        context = transition[name]
        need(context["proof_context_sha256"] == canonical_sha({k: v for k, v in context.items() if k != "proof_context_sha256"}), "Proof context checksum differs")
        for module in context["external_modules"]:
            ref(root, module)
        for field in ("layout_library_preparation", "target_layout_file"):
            if field in context:
                ref(root, context[field])
    need(transition["legacy_context"]["proof_context_sha256"] != transition["active_context"]["proof_context_sha256"], "Legacy and ABI contexts must remain distinct")
    active = transition["active_context"]
    need({d["module"]: d["sha256"] for d in active["external_modules"]} == abi_context["modules"], "Transition labels another ABI dependency context")
    need(canonical_sha(active["target_layout"]) == abi_context["target_layout_canonical_sha256"], "Transition target layout differs from proof ABI")
    need(active["layout_library_preparation"]["sha256"] == abi_context["preparation_manifest_sha256"] and active["target_layout_file"]["sha256"] == abi_context["target_layout_sha256"], "Transition layout provenance differs from proof ABI")
    mappings = transition["per_execution_cost_mapping"]
    need(len(rows) == len(mappings) == len(legacy_native["runs"]) == 28, "Context transition changes native denominator")
    by_row, old_indices, keys, old_receipts = {}, set(), set(), []
    for m in mappings:
        i, j = m["active_native_row_index"], m["legacy_native_row_index"]
        need(i not in by_row and j not in old_indices and 0 <= i < 28 and 0 <= j < 28, "Duplicate native cost mapping")
        old_indices.add(j)
        row, old = rows[i], legacy_native["runs"][j]
        key = execution_key(row)
        need(key == execution_key(old) == m["execution_key"] and key not in keys, "Context transition execution identity differs")
        keys.add(key)
        for field in ("case", "strategy", "spatial_smt", "source_sha256"):
            need(m[field] == row[field], "Transition execution field differs: " + field)
        need(m["input_sha256"] == canonical_sha(row["input"]), "Transition input differs")
        need(m["legacy_native_stage"] == native_stage(old) and m["active_native_stage"] == native_stage(row), "Context native cost differs from actual execution")
        for stage in (m["legacy_native_stage"], m["active_native_stage"]):
            number(stage["wall_seconds"], "native attempt time")
            number(stage["peak_process_rss_kib"], "native attempt RSS", True)
            need(stage["tokens"] == stage["model_calls"] == 0, "Native attempt unexpectedly used a model")
        need(m["legacy_itp_included_in_final_cost"] is True, "Legacy costs excluded")
        if m["legacy_itp_receipt"] is not None:
            old_receipt = load(ref(root, m["legacy_itp_receipt"]))
            need(old_receipt["metrics"] == m["legacy_itp_metrics"], "Legacy cost summary differs")
            old_receipts.append(m["legacy_itp_receipt"])
        else:
            need(m["legacy_itp_metrics"] is None, "Unbound legacy costs")
        by_row[i] = m
    expected_refs = [e["receipt"] for e in legacy_progress["executions"] if e.get("receipt")]
    need(sorted((x["path"], x["sha256"]) for x in old_receipts) == sorted((x["path"], x["sha256"]) for x in expected_refs), "Context transition omits/repeats a historical ITP execution")
    need(len(old_receipts) == 2, "Singleton legacy parent proof inventory differs")
    archived = [load(ref(root, item)) for item in old_receipts]
    for key, metric in (("model_calls", "model_calls"), ("check_attempts", "check_attempts"), ("tokens", "tokens")):
        need(sum(r["metrics"]["total"][metric] for r in archived) == legacy_progress[key] == transition["measured_totals_to_date"][key], "Legacy attempt inventory cost differs: " + key)
    need(sum(r["metrics"]["total"]["wall_seconds"] for r in archived) == transition["measured_totals_to_date"]["itp_wall_seconds"], "Legacy ITP time inventory differs")
    need([m for r in archived for m in r["missing_measurements"]] == transition["measured_totals_to_date"]["missing_measurements"], "Legacy missing RSS inventory differs")
    need(sum(m["legacy_native_stage"]["wall_seconds"] + m["active_native_stage"]["wall_seconds"] for m in mappings) == transition["measured_totals_to_date"]["native_wall_seconds"], "Transition native cost sum differs")
    return transition, by_row


def audit_shared_setup(root, setup, transition, task_overrides=None, task_inventory_sha256=None, recovery_audits=None, evidence_reader=None):
    from validate_canonical_group import ref as disk_ref, load, digest, number, hash_value
    ref = evidence_reader or disk_ref
    expected_names = {"context_preparation"} | ({"native_recovery_preparation"} if task_overrides else set())
    need(set(setup) == expected_names, "Shared setup stages missing or repeated")
    original = setup["context_preparation"]
    need(original == transition["group_shared_setup"]["context_preparation"], "Original shared preparation cost changed")
    text = original["raw_resources_text"]
    need(hashlib.sha256(text.encode()).hexdigest() == original["raw_resources_sha256"], "Original setup resource text hash differs")
    parts = text.split()
    need(len(parts) == 2 and float(parts[0]) == original["wall_seconds"] and int(parts[1]) == original["peak_process_rss_kib"], "Original setup GNU time values differ")
    need(original["tokens"] == original["model_calls"] == 0, "Original setup has invented model costs")
    for key in ("raw_receipt_sha256", "preparation_script_sha256", "source_manifest_sha256"):
        hash_value(original[key], "shared setup " + key)
    ref(root, original["preparation_manifest"])
    for item in original["prepared_modules"]:
        ref(root, item)
    if task_overrides:
        import re
        repair = setup["native_recovery_preparation"]
        receipt = load(ref(root, repair["receipt"]))
        need(receipt["schema"] == "tespec-native-recovery-setup/v1" and receipt["tasks_override_sha256"] == task_overrides["sha256"] and receipt["original_tasks_sha256"] == task_inventory_sha256, "Recovery setup task provenance differs")
        need(receipt["tokens"] == receipt["model_calls"] == receipt["Coq_calls"] == repair["tokens"] == repair["model_calls"] == 0, "Recovery setup has invented proof/model charges")
        need({a["execution_index"]: a["audit"] for a in receipt["audits"]} == recovery_audits, "Recovery setup does not match all six actual executions")
        text = ref(root, repair["resources"]).read_text()
        need(text == repair["raw_resources"], "Recovery setup raw resources differ")
        values = re.fullmatch(r"wall_seconds=([0-9.]+)(?:n|\n)user_seconds=([0-9.]+)(?:n|\n)system_seconds=([0-9.]+)(?:n|\n)max_process_rss_kib=([0-9]+)\s*", text)
        need(values is not None, "Malformed recovery setup GNU time record")
        wall, user, system, rss = values.groups()
        need((float(wall), float(user), float(system), int(rss)) == (repair["wall_seconds"], repair["cpu_user_seconds"], repair["cpu_system_seconds"], repair["peak_process_rss_kib"]), "Recovery preparation values do not match external GNU time")
        need(digest(ref(root, repair["source"])) == "9ac74681082a2bf2899102194b9175138063241836564a0fd1d5260121a2952d", "Recovery preparation source differs")
        need(repair["captured_actual_argv"] is None and repair.get("command_evidence"), "Uncaptured actual argv must not be invented")
    for stage in setup.values():
        number(stage["wall_seconds"], "shared setup time")
        number(stage["peak_process_rss_kib"], "shared setup RSS", True)
    return setup


def group_workload(rows, receipts, setup):
    """teSpec workload, counting shared setup once and attempts per logical input."""
    native_seconds = sum(native_cost(row)[0] for row in rows)
    setup_seconds = sum(value["wall_seconds"] for value in setup.values())
    costs = [r["metrics"]["total"] for r in receipts]
    itp_complete = all(c["wall_seconds"] is not None for c in costs)
    itp_seconds = sum(c["wall_seconds"] for c in costs) if itp_complete else None
    known = sum(c.get("known_wall_seconds_lower_bound", c.get("wall_seconds")) or 0 for c in costs)
    lower_peaks = [native_cost(row)[1] * 1024 for row in rows] + [s["peak_process_rss_kib"] * 1024 for s in setup.values()] + [c["observed_peak_rss_lower_bound_bytes"] for c in costs]
    rss_complete = all(c["peak_process_resident_bytes"] is not None for c in costs)
    return {"scope": "teSpec native attempts, all per-execution ITP attempts, shared preparation once; no repeated ITP total rows", "native_executions": len(rows), "itp_executions": len(receipts),
        "native_wall_seconds_total": native_seconds, "itp_wall_seconds_total": itp_seconds,
        "shared_setup_wall_seconds_total": setup_seconds,
        "wall_seconds_total": native_seconds + setup_seconds + itp_seconds if itp_complete else None,
        "known_wall_seconds_lower_bound": native_seconds + setup_seconds + known,
        "wall_time_complete": itp_complete, "peak_process_resident_bytes": max(lower_peaks) if rss_complete else None,
        "observed_peak_rss_lower_bound_bytes": max(lower_peaks), "resource_metrics_complete": rss_complete and itp_complete,
        "tokens": sum(c["tokens"] for c in costs), "model_calls": sum(c["model_calls"] for c in costs)}
