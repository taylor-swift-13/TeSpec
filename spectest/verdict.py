"""Validate the executor protocol and assign a conservative test verdict."""

from __future__ import annotations

import json
from typing import Any

from .errors import JobError


def aggregate_test_result(
    precondition: str, vc_states: list[str], *, complete: bool
) -> str:
    """Conjoin entry satisfiability, VC validity, and execution coverage."""
    if precondition not in {"SAT", "UNSAT", "UNKNOWN"}:
        raise JobError("invalid precondition result")
    if any(state not in {"VALID", "INVALID", "UNKNOWN"} for state in vc_states):
        raise JobError("invalid VC state")
    if precondition == "UNSAT" or "INVALID" in vc_states:
        return "FAIL"
    if precondition == "SAT" and complete and all(
        state == "VALID" for state in vc_states
    ):
        return "PASS"
    return "UNKNOWN"


def _executor_target_layout(output: str | None) -> dict[str, Any] | None:
    if output is None:
        return None
    try:
        executor = json.loads(output)
    except json.JSONDecodeError:
        return None
    result = executor.get("spec_test") if isinstance(executor, dict) else None
    layout = result.get("target_layout") if isinstance(result, dict) else None
    if layout is None:
        return None
    if (
        not isinstance(layout, dict)
        or layout.get("schema") != "sac-target-layout/v1"
        or type(layout.get("architecture_bits")) is not int
        or layout["architecture_bits"] not in (32, 64)
        or layout["architecture_bits"] != result.get("architecture_bits")
        or layout.get("pointer_size") != layout["architecture_bits"] // 8
        or not isinstance(layout.get("aggregates"), list)
    ):
        raise JobError("invalid executor target-layout metadata")
    return layout


def _executor_result(
    output: str, returncode: int, vc: dict[str, Any]
) -> dict[str, Any]:
    """Consume executor JSON. Missing fields are explicitly unknown, not success."""
    try:
        executor = json.loads(output)
    except json.JSONDecodeError:
        executor = None
    if not isinstance(executor, dict):
        return {
            "status": "ERROR",
            "overall": "ERROR",
            "satisfied": None,
            "reason": "invalid_executor_json",
            "phases": {
                "precondition": "NOT_CHECKED",
                "safety": "NOT_CHECKED",
                "postcondition": "NOT_CHECKED",
                "annotations": "NOT_CHECKED",
            },
        }
    result = executor.get("spec_test")
    if not isinstance(result, dict) or result.get("schema") != "sac-spec-test/v1":
        return {
            "status": "UNKNOWN" if not executor.get("errormessage") else "ERROR",
            "overall": "UNKNOWN" if not executor.get("errormessage") else "ERROR",
            "satisfied": None,
            "reason": "legacy_executor_missing_test_semantics",
            "scope": "NOT_REPORTED",
            "phases": {
                "precondition": "NOT_CHECKED",
                "safety": "NOT_CHECKED",
                "postcondition": "NOT_CHECKED",
                "annotations": "NOT_CHECKED",
            },
            "legacy_verification_status": executor.get("verificationStatus"),
        }
    required_phases = {"precondition", "safety", "postcondition", "annotations"}
    if (
        not isinstance(result.get("phases"), dict)
        or not required_phases.issubset(result["phases"])
        or result.get("scope") not in {"execution", "specification-only"}
        or result.get("mode") not in {"expand", "no-expand"}
        or "certificate" not in result
    ):
        return {
            "status": "ERROR",
            "overall": "ERROR",
            "satisfied": None,
            "reason": "incomplete_executor_schema",
        }
    status = result.get("overall")
    if status not in {"PASS", "FAIL", "UNKNOWN", "ERROR", "INVALID"}:
        raise JobError("invalid structured executor verdict")
    reported_status = status
    vc_results = result.get("vc_results", [])
    if not isinstance(vc_results, list) or any(
        not isinstance(v, dict)
        or v.get("status") not in {"VALID", "INVALID", "UNKNOWN"}
        for v in vc_results
    ):
        raise JobError("invalid per-VC result")
    path_vcs = result.get("vc_semantics") == "path-vc/v1"
    conjunction = result.get("result_semantics") == "three-valued-conjunction/v1"
    if conjunction and (
        result.get("precondition_result") not in {"SAT", "UNSAT", "UNKNOWN"}
        or result.get("test_result") not in {"PASS", "FAIL", "UNKNOWN"}
    ):
        raise JobError("incomplete three-valued executor result")
    invalid_vcs = [v for v in vc_results if v["status"] == "INVALID"]
    confirmed_fail = (
        path_vcs
        and bool(invalid_vcs)
        and (conjunction or result["phases"]["precondition"] == "SAT")
        and result["scope"] == "execution"
    )
    entry_unsat = conjunction and result["precondition_result"] == "UNSAT"
    if confirmed_fail or entry_unsat:
        status = "FAIL"
    elif status == "FAIL":
        status = "UNKNOWN"
    phases = dict(result["phases"])
    phases["execution"] = (
        "NOT_RUN"
        if result["scope"] == "specification-only"
        or phases["safety"] == phases["postcondition"] == "NOT_RUN"
        else "PASS"
        if result.get("completed") is True
        or (
            "completed" not in result
            and phases["safety"] == phases["postcondition"] == "PASS"
        )
        else "UNKNOWN"
    )
    if status == "PASS":
        if result["scope"] == "execution":
            phases_complete = (
                result.get("completed") is True
                and phases["execution"] == "PASS"
                and phases["safety"] == phases["postcondition"] == "PASS"
                and (
                    phases["annotations"] == "PASS"
                    or (
                        result["mode"] == "expand"
                        and result.get("annotation_policy") in (None, "ignore")
                        and phases["annotations"] == "NOT_RUN"
                    )
                )
            )
        else:
            phases_complete = all(
                phases[key] == "NOT_RUN"
                for key in ("execution", "safety", "postcondition", "annotations")
            )
        if not phases_complete or executor.get("errormessage"):
            status = "ERROR"
    if status == "PASS" and (returncode != 0 or phases["precondition"] != "SAT"):
        status = "ERROR"
    if status == "INVALID" and phases["precondition"] != "UNSAT":
        status = "ERROR"
    if status == "PASS" and vc["status"] == "not_generated":
        status = "ERROR"
    if status == "PASS" and (
        vc["residual_goals"] or any(v["status"] == "UNKNOWN" for v in vc_results)
    ):
        status = "UNKNOWN"
    reason = (
        result.get("limit_reason")
        or {
            "PASS": "qcp_full_auto_passed",
            "INVALID": "bindings_violate_require",
            "ERROR": "qcp_execution_error",
            "UNKNOWN": "residual_vc_requires_proof",
            "FAIL": "confirmed_counterexample",
        }[status]
    )
    if (
        status == "UNKNOWN"
        and phases["precondition"] == "UNKNOWN"
        and not result.get("limit_reason")
    ):
        reason = "precondition_requires_proof"
    if reported_status == "FAIL" and not confirmed_fail and not entry_unsat:
        reason = "execution_counterexample_not_checked"
    if confirmed_fail:
        reason = "invalid_path_vc"
    if entry_unsat:
        reason = "bindings_violate_require"
    entry_result = phases["precondition"]
    if conjunction:
        entry_result = result["precondition_result"]
    test_result = status if status in {"PASS", "FAIL", "UNKNOWN"} else None
    if conjunction:
        test_result = aggregate_test_result(
            entry_result,
            [v["status"] for v in vc_results],
            complete=status == "PASS",
        )
        if test_result != result["test_result"]:
            raise JobError("executor test result disagrees with obligation conjunction")
    return {
        "status": status,
        "overall": status,
        "precondition_result": entry_result
        if entry_result in ({"SAT", "UNSAT", "UNKNOWN"} if conjunction else {"SAT", "UNSAT"})
        else None,
        "test_result": test_result,
        "result_semantics": result.get("result_semantics"),
        "executor_reported_status": reported_status,
        "satisfied": True if status == "PASS" else False if status == "FAIL" else None,
        "reason": reason,
        "phases": phases,
        "scope": result["scope"],
        "mode": result["mode"],
        "execution_semantics": result.get("execution_semantics"),
        "execution_completed": (
            False if phases["execution"] == "NOT_RUN" else result.get("completed")
        ),
        "annotation_policy": result.get("annotation_policy"),
        "preconditions": executor.get("preconditions", []),
        "abstraction_events": result.get("abstraction_events", []),
        "architecture_bits": result.get("architecture_bits"),
        "target_layout": _executor_target_layout(output),
        "executor_error": executor.get("errormessage"),
        "residual_vcs": vc["residual_goals"],
        "vc_results": vc_results,
        "evidence": {
            "decision_backend": "qcp-smt",
            "certificate": "NOT_CHECKED"
            if reported_status == "FAIL"
            else result["certificate"],
        },
    }
