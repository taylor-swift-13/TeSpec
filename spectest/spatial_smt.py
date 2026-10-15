"""Optional post-execution spatial VC decision stage with immutable ITP fallback.

This consumes copy-only path VCs after native execution. It never resumes an
interrupted execution or changes the original executor/Coq artifacts.
"""

from __future__ import annotations

from copy import deepcopy
import hashlib
import json
from pathlib import Path
import re
import time


def _solve_record(record: dict, timeout_ms: int) -> dict:
    # Do not import Z3 when this feature is disabled (or for existing decisions).
    from tools.finite_spatial_smt.finite_spatial_smt import check, Unsupported
    from tools.finite_spatial_smt.qcp_import import import_record

    try:
        vc = import_record(record)
    except Unsupported as error:
        return {"status": "UNKNOWN", "supported": False, "reason": str(error)}
    result = check(vc, timeout_ms=timeout_ms, include_smt=True)
    result["normalized_vc"] = vc
    return result


def _return_coverage(executor: dict, original: list, residual: list) -> bool:
    """Discharge a whole return-only residual group, never guess per-lemma IDs.

    Native return records currently have null names. Require agreement between the
    manual inventory, witness totals and returned path VCs before concluding PASS.
    Mixed/unmapped obligations remain ITP tasks even if some VCs were decided.
    """
    fn = executor.get("functionName")
    manual = executor.get("manual_obligations")
    witnesses = executor.get("WitnessList")
    if not isinstance(fn, str) or not isinstance(manual, list) or not manual:
        return False
    returns = [v for v in original if v.get("kind") == "return"]
    unknown = [v for v in returns if v.get("status") == "UNKNOWN"]
    if executor.get("manual_obligation_count") != len(manual) or len(manual) != len(
        unknown
    ):
        return False
    if any(
        m.get("kind") != "return_checker_wit" or m.get("functionName") != fn
        for m in manual
    ):
        return False
    if sorted(m.get("line", -1) for m in manual) != sorted(
        v.get("line", -2) for v in unknown
    ):
        return False
    if not isinstance(witnesses, list) or len(witnesses) != 1:
        return False
    witness = witnesses[0]
    if witness.get("functionName") != fn:
        return False
    counts = witness.get("Witness", {}).get("return_checker_wit", {})
    if counts.get("total") != len(returns) or counts.get("manual") != len(manual):
        return False
    pattern = re.compile(
        r"proof_of_"
        + re.escape(fn)
        + r"_return_wit_[0-9]+(?:_split_goal_[A-Za-z0-9_]+)?\Z"
    )
    return bool(residual) and all(
        isinstance(g, str) and pattern.fullmatch(g) for g in residual
    )


def refine_case(
    case: dict, stdout_path: Path, artifact_dir: Path, *, timeout_ms: int
) -> None:
    """Refine supported UNKNOWN return VCs; leave all original proof files intact."""
    started = time.monotonic()
    info = {
        "backend": "finite-spatial-smt/v1",
        "enabled": True,
        "certificate": "NOT_CHECKED",
        "stage": "after_executor",
        "timeout_ms_per_query": timeout_ms,
        "attempted": 0,
        "itp_required": bool(case.get("residual_vcs")),
        "results": [],
        "original_status": case.get("status"),
        "original_reason": case.get("reason"),
    }
    case["spatial_smt"] = info
    # Never turn executor errors, incomplete/abstract executions, or entry
    # uncertainty into a counterexample to a concrete test.
    if (
        case.get("status") != "UNKNOWN"
        or case.get("scope") != "execution"
        or case.get("execution_completed") is not True
        or case.get("precondition_result") != "SAT"
        or case.get("executor_error")
        or case.get("returncode") != 0
        or case.get("abstraction_events")
    ):
        info["reason"] = "original_execution_not_eligible"
        return
    try:
        raw_bytes = stdout_path.read_bytes()
        executor = json.loads(raw_bytes)
        native = executor["spec_test"]
        if (
            native.get("schema") != "sac-spec-test/v1"
            or native.get("vc_semantics") != "path-vc/v1"
            or native.get("query_semantics") != "copy-only/v1"
            or native.get("execution_semantics") != "inline-preserve/v1"
            or native.get("result_semantics") != "three-valued-conjunction/v1"
            or native.get("limit_reason")
            or native.get("vc_results") != case.get("vc_results")
        ):
            info["reason"] = "unsupported_executor_protocol"
            return
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as error:
        info["reason"] = "executor_artifact_unavailable:" + str(error)
        return
    original = case["vc_results"]
    refined = deepcopy(original)
    artifact_dir.mkdir(parents=True, exist_ok=True)
    info["executor_sha256"] = hashlib.sha256(raw_bytes).hexdigest()
    for index, obligation in enumerate(original):
        if obligation.get("status") != "UNKNOWN":
            continue
        record = {"layout": case.get("target_layout"), "vc": obligation}
        # Dependency errors, parser failures and SMT failures must never be
        # interpreted as invalid bindings or discard the existing ITP task.
        try:
            decision = _solve_record(record, timeout_ms)
        except Exception as error:
            decision = {
                "status": "UNKNOWN",
                "reason": "backend_error:" + type(error).__name__ + ":" + str(error),
            }
        if decision.get("status") not in {"VALID", "INVALID", "UNKNOWN"}:
            decision = {"status": "UNKNOWN", "reason": "invalid_backend_status"}
        decision["certificate"] = "NOT_CHECKED"
        decision["vc_index"] = index
        decision["input"] = record
        smt = decision.pop("smt2", None)
        if smt is not None:
            query_path = artifact_dir / f"vc-{index:04d}.smt2"
            query_path.write_text(smt, encoding="utf-8")
            decision["query"] = str(query_path)
            decision["query_sha256"] = hashlib.sha256(
                query_path.read_bytes()
            ).hexdigest()
        path = artifact_dir / f"vc-{index:04d}.json"
        path.write_text(json.dumps(decision, indent=2) + "\n", encoding="utf-8")
        item = {k: decision[k] for k in ("vc_index", "status", "reason", "certificate")}
        item["artifact"] = str(path)
        info["results"].append(item)
        refined[index]["status"] = decision["status"]
        refined[index]["original_status"] = "UNKNOWN"
        refined[index]["spatial_smt"] = item
    info["attempted"] = len(info["results"])
    info["wall_seconds"] = time.monotonic() - started
    case["vc_results"] = refined
    states = [v["status"] for v in refined]
    phases = dict(case["phases"])
    returns = [v for v in refined if v.get("kind") == "return"]
    if returns and any(v["status"] == "INVALID" for v in returns):
        phases["postcondition"] = "FAIL"
    elif returns and all(v["status"] == "VALID" for v in returns):
        # Coverage is checked below before changing the final verdict.
        phases["postcondition"] = "PASS"
    complete = (
        phases.get("execution") == "PASS"
        and phases.get("safety") == "PASS"
        and phases.get("postcondition") == "PASS"
        and (
            phases.get("annotations") == "PASS"
            or (
                case.get("mode") == "entry-exit"
                and case.get("annotation_policy") in (None, "ignore")
                and phases.get("annotations") == "NOT_RUN"
            )
        )
    )
    try:
        coverage = _return_coverage(executor, original, case.get("residual_vcs", []))
    except (TypeError, AttributeError):
        coverage = False
    info["return_residual_coverage"] = coverage
    status = case["status"]
    if "INVALID" in states:
        status = "FAIL"
        case["reason"] = "spatial_smt_invalid_path_vc"
    elif states and all(s == "VALID" for s in states) and complete and coverage:
        status = "PASS"
        case["reason"] = "spatial_smt_valid_path_vcs"
    if status != case["status"]:
        case.update(
            status=status,
            overall=status,
            test_result=status,
            satisfied=status == "PASS",
            phases=phases,
        )
        case["evidence"] = {
            "decision_backend": "qcp-smt+finite-spatial-smt",
            "certificate": "NOT_CHECKED",
        }
    # Keep proof files/manifest/residual list unchanged as archival certificate
    # inputs. The scheduling list excludes groups fully decided for this test.
    info["itp_required"] = bool(case.get("residual_vcs")) and (
        status == "UNKNOWN" or "UNKNOWN" in states or not coverage
    )
    summary_path = artifact_dir / "summary.json"
    summary_path.write_text(json.dumps(info, indent=2) + "\n", encoding="utf-8")
    info["summary"] = str(summary_path)
