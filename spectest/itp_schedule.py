"""Plan per-execution decision work while retaining the full Coq inventory."""

import json
from pathlib import Path
import re


FAMILIES = {"return": "return", "entailment": "entail", "safety": "safety"}


def bind_proof_roots(function, records, binding):
    """Use exact native printer identities. Multiple occurrences can share a VC."""
    interface = set(binding["all_interface_roots"])
    roots = set(binding["interface_roots"])
    owners = {}
    for index, record in enumerate(records):
        names = record.get("proof_roots", [])
        family = FAMILIES.get(record.get("kind"))
        if not isinstance(names, list) or (names and not family):
            raise ValueError("invalid_native_proof_roots")
        for name in names:
            pattern = re.escape(function) + "_" + family + r"_wit_[1-9][0-9]*(?:_\w+)?"
            if not isinstance(name, str) or not re.fullmatch(pattern, name):
                raise ValueError("native_root_family_mismatch")
            proof = "proof_of_" + name
            if proof not in interface or proof in owners:
                raise ValueError("unknown_or_duplicate_native_root")
            owners[proof] = index
    return {root: owners[root] for root in sorted(roots & owners.keys())}


def decision_goals(case, binding, owners, *, native_negative=False):
    """A VALID raw disjunct suffices. A raw INVALID alone cannot refute an OR."""
    residual = case["residual_vcs"]
    records = case["vc_results"]
    roots = set(binding["interface_roots"])
    pending = {root for root in roots if root not in owners
               or records[owners[root]]["status"] != "VALID"}
    # An already validated native counterexample settles the execution verdict,
    # subject to higher-priority safety failures. Require complete origin coverage
    # before concluding there are no unreported safety obligations.
    pending_safety = {i for i, record in enumerate(records)
                      if record["kind"] == "safety" and record["status"] == "UNKNOWN"}
    if native_negative and roots == owners.keys() and pending_safety <= set(owners.values()):
        if case["status"] == "CRASH":
            pending.clear()
        elif case["status"] == "FAIL":
            safety = {root for root in pending if records[owners[root]]["kind"] == "safety"}
            if safety or case["phases"].get("safety") == "PASS":
                pending = safety
    # Filter only goals with an unambiguous parent from the actual module interface.
    # No split helper is promoted to a standalone execution result.
    goals = []
    for name in residual:
        if name in roots:
            parent = name
        else:
            candidates = [root for root in roots if name.startswith(root + "_split_goal_")]
            if len(candidates) != 1:
                return list(residual)
            parent = candidates[0]
        if parent in pending:
            goals.append(name)
    return goals


def native_negative_for_test(case, original, owners):
    """Use the validated native verdict, never a countermodel of an auxiliary."""
    reason = {"FAIL": "invalid_path_vc", "CRASH": "invalid_safety_vc"}.get(case.get("status"))
    kind_filter = {"safety"} if case.get("status") == "CRASH" else {"return", "entailment"}
    return bool(
        reason and case.get("reason") == reason and case.get("scope") == "execution"
        and case.get("precondition_result") == "SAT" and case.get("execution_completed") is True
        and case.get("returncode") == 0 and not case.get("executor_error")
        and any(original[i]["status"] == "INVALID" and original[i]["kind"] in kind_filter
                for i in owners.values())
    )


def _native_decision_goals(case):
    records = case.get("vc_results", [])
    if (case.get("reason") not in {"invalid_path_vc", "invalid_safety_vc"}
            or not any(v.get("proof_roots") and v.get("status") == "INVALID" for v in records)):
        return None
    from .spatial_smt import _checked_events, _obligation_artifacts
    try:
        raw = json.loads(Path(case["stdout"]).read_bytes())
        native = raw["spec_test"]
        if (native.get("schema") != "sac-spec-test/v1" or native.get("vc_semantics") != "path-vc/v1"
                or native.get("result_semantics") != "three-valued-conjunction/v1"
                or native.get("vc_results") != records or native.get("limit_reason")
                or not _checked_events(case, native, raw["functionName"])):
            return None
        binding = _obligation_artifacts(case, raw)
        owners = bind_proof_roots(raw["functionName"], records, binding)
        if native_negative_for_test(case, records, owners):
            return decision_goals(case, binding, owners, native_negative=True)
    except (OSError, ValueError, KeyError, TypeError, AttributeError):
        pass
    return None


def decision_itp_task(case, function):
    manifest = case.get("vc")
    if not isinstance(manifest, dict) or manifest.get("status") != "residual":
        return None
    residual = manifest.get("residual_goals", [])
    if not residual:
        return None
    spatial = case.get("spatial_smt", {})
    if spatial.get("itp_required") is False:
        return None
    goals = spatial.get("decision_goals")
    if goals is None and (not spatial or spatial.get("reason") == "no_unknown_vcs"):
        goals = _native_decision_goals(case)
    if not isinstance(goals, list) or any(name not in residual for name in goals):
        goals = residual
    if not goals:
        if spatial:
            spatial["itp_required"] = False
        return None
    return {"case_id": case["id"], "function": function, "manifest": manifest["manifest"],
            "goals": list(goals)}
