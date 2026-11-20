"""Controller-owned reconciliation of automatic runs and complete VC proofs."""

from __future__ import annotations

from collections import Counter
import copy
import hashlib
import json
from pathlib import Path
import re

from .certificates import check_certificate, digest, prepare_certificate
from .core import JobError
from .itp_schedule import bind_proof_roots, decision_itp_task
from .modes import EXECUTION_SEMANTICS
from .kernel_replay import KernelReplayCache
from .verdict import CASE_STATUSES


def _eligible(case: dict, *, decision_only=False) -> bool:
    # A known functional failure may still have a higher-priority safety VC.
    pending_safety = (
        decision_only and case.get("status") == "FAIL"
        and case.get("precondition_result") == "SAT"
        and any(v.get("kind") == "safety" and v.get("status") == "UNKNOWN"
                for v in case.get("vc_results", []))
    )
    if (
        (not pending_safety and any(v.get("status") == "INVALID" for v in case.get("vc_results", [])))
        or (not pending_safety and (
            case.get("status") != "UNKNOWN" or case.get("reason") not in
            {"precondition_requires_proof", "residual_vc_requires_proof"}
        ))
        or case.get("executor_error")
        or case.get("execution_semantics") not in EXECUTION_SEMANTICS.values()
    ):
        return False
    phases = case.get("phases", {})
    if phases.get("precondition") not in {"SAT", "UNKNOWN"}:
        return False
    if case.get("scope") == "specification-only":
        return all(
            phases.get(k) == "NOT_RUN" for k in ("safety", "postcondition", "execution")
        )
    return (
        case.get("scope") == "execution"
        and case.get("execution_completed") is True
        and phases.get("execution") == "PASS"
        and (pending_safety or all(
            phases.get(k) in {"PASS", "UNKNOWN", "NOT_CHECKED", "NOT_RUN"}
            for k in ("safety", "postcondition", "annotations")
        ))
        and phases.get("safety") in {"PASS", "UNKNOWN"}
        and (pending_safety or phases.get("postcondition") in {"PASS", "UNKNOWN"})
    )


def _residual_covered(name: str, proofs: set[str]) -> bool:
    """QCP splits are covered by proving their original complete obligation."""
    if name in proofs:
        return True
    parent = re.sub(r"_split_goal_(?:[0-9]+|spatial)$", "", name)
    return parent != name and parent in proofs


def _precondition_refutation_goal(case: dict) -> str:
    """Only a single whole-Require satisfiability goal has this verdict scope.

    Disjuncts of one Require are already inside that original goal. Multiple
    specification entries need separate domain accounting, not an arbitrary
    choice of a branch whose refutation invalidates the whole case.
    """
    preconditions = case.get("preconditions", [])
    if (
        len(preconditions) != 1
        or preconditions[0].get("status") != "UNKNOWN"
        or case.get("phases", {}).get("precondition") != "UNKNOWN"
        or not isinstance(preconditions[0].get("goal"), str)
        or "--precondition-proof-negation" in case.get("command", [])
    ):
        raise JobError("refutation requires one unresolved positive Require SAT VC")
    return "proof_of_" + preconditions[0]["goal"]


def _checked_refinements(case, stdout_path, stdout, native, records):
    """A partial kernel check may rely only on spatial decisions from this run."""
    changed = [i for i, (old, new) in enumerate(zip(native, records))
               if old["status"] != new["status"]]
    if not changed:
        return True
    info = case.get("spatial_smt", {})
    folder = stdout_path.parent / "spatial-smt"
    summary = json.loads((folder / "summary.json").read_bytes())
    executor_hash = hashlib.sha256(stdout).hexdigest()
    if (info.get("executor_sha256") != executor_hash
            or summary.get("executor_sha256") != executor_hash):
        return False
    summary_items = {item["vc_index"]: item for item in summary["results"]}
    if len(summary_items) != len(summary["results"]):
        return False
    for i in changed:
        new_status = records[i]["status"]
        if native[i]["status"] != "UNKNOWN" or new_status not in {"VALID", "INVALID"}:
            return False
        receipt_path = folder / f"vc-{i:04d}.json"
        item = records[i].get("spatial_smt")
        if (not isinstance(item, dict) or item.get("vc_index") != i
                or item.get("status") != new_status or item.get("artifact") != str(receipt_path)
                or summary_items.get(i) != item):
            return False
        receipt = json.loads(receipt_path.read_bytes())
        if (receipt.get("status") != new_status or receipt.get("vc_index") != i
                or receipt.get("solver_result") != ("unsat" if new_status == "VALID" else "sat")
                or receipt["input"].get("layout") != case["target_layout"]
                or receipt["input"].get("vc") != native[i]):
            return False
    return True


def _decision_binding(case):
    """Bind original diagnostic formulas to parent names printed by this executor."""
    from .spatial_smt import _obligation_artifacts

    try:
        stdout_path = Path(case["stdout"])
        stdout = stdout_path.read_bytes()
        executor = json.loads(stdout)
        binding = _obligation_artifacts(case, executor)
        native = executor["spec_test"]["vc_results"]
        # Status may have been refined; identity and formulas must be the
        # original native ones, including all coalesced occurrences.
        records = case.get("vc_results", [])
        if records and not any(vc.get("proof_roots") for vc in native):
            return None
        if len(native) != len(records) or any(
            any(old.get(key) != new.get(key) for key in ("kind", "line", "path", "goal", "proof_roots"))
            for old, new in zip(native, records)
        ):
            return None
        if not _checked_refinements(case, stdout_path, stdout, native, records):
            return None
        owners = bind_proof_roots(case["vc"]["function"], native, binding)
        if executor.get("preconditions") != case.get("preconditions"):
            return None
    except (OSError, AttributeError, KeyError, TypeError, ValueError):
        # Older executors and synthetic reports keep full-group checking.
        return None
    return binding, owners


def _decision_roots(case, goals, origin):
    """Select original interface lemmas only for an audited native inventory."""
    if origin is None:
        return None
    binding, owners = origin
    records = case["vc_results"]
    if not isinstance(case.get("preconditions"), list) or any(
        not isinstance(p, dict) or not isinstance(p.get("goal"), str)
        or p.get("status") not in {"SAT", "UNKNOWN"} for p in case["preconditions"]
    ):
        return None
    roots = {"proof_of_" + p["goal"] for p in case["preconditions"]
             if p["status"] == "UNKNOWN"}
    interface = set(binding["interface_roots"])
    for name in goals:
        parent = re.sub(r"_split_goal_(?:[0-9]+|spatial)$", "", name)
        roots.add(name if name in interface else parent)
    if not roots or not roots <= interface:
        return None
    # Every omitted manual root must have an independent automatic decision.
    # For an established functional failure, only safety can change its class.
    for omitted in interface - roots:
        if omitted not in owners:
            return None
        row = records[owners[omitted]]
        if row["status"] != "VALID" and not (case["status"] == "FAIL" and row["kind"] != "safety"):
            return None
    # An unmapped path VC cannot be discharged merely by proving some roots.
    for vc in case.get("vc_results", []):
        if vc["status"] != "UNKNOWN":
            continue
        if case["status"] == "FAIL" and vc["kind"] != "safety":
            continue
        refs = vc.get("proof_roots")
        if not refs or any("proof_of_" + ref not in roots for ref in refs):
            return None
    phase_kinds = {"safety": {"safety"}, "postcondition": {"return"},
                   "annotations": {"entailment", "which_implies", "partial_solve"}}
    for phase, kinds in phase_kinds.items():
        if case["phases"].get(phase) == "UNKNOWN" and not any(
            v["kind"] in kinds and v.get("proof_roots") for v in records
        ):
            return None
    return roots


def prepare_run_certificates(
    report_path: Path, output: Path, *, refute_preconditions: set[str] | None = None,
    refute_vcs: dict[str, str] | None = None, decision_only: bool = False,
    only_case_ids: set[str] | None = None,
) -> dict:
    """Freeze a trusted automatic report before handing proof files to an agent."""
    report = json.loads(report_path.read_text())
    if report.get("schema") != "qcp-spectest-report/v1":
        raise JobError("expected an automatic spec-test report")
    results = report["results"]
    if not isinstance(results, list) or not results:
        raise JobError("automatic report must contain at least one test case")
    ids = [case["id"] for case in results]
    if len(set(ids)) != len(ids):
        raise JobError("duplicate automatic case id")
    refute_preconditions = set(refute_preconditions or ())
    refute_vcs = dict(refute_vcs or {})
    if refute_preconditions & set(refute_vcs):
        raise JobError("choose one refutation target per case")
    if set(refute_vcs) - set(ids):
        raise JobError("VC refutation names an unknown case")
    if refute_preconditions - set(ids):
        raise JobError("precondition refutation names an unknown case")
    if only_case_ids is not None and (only_case_ids - set(ids) or
                                      (refute_preconditions | refute_vcs.keys()) - only_case_ids):
        raise JobError("invalid selected execution IDs")
    for case in results:
        if case["id"] in refute_vcs and not _eligible(case, decision_only=decision_only):
            raise JobError("case is not eligible for VC refutation")
        if case["id"] in refute_preconditions:
            if not _eligible(case, decision_only=decision_only) or not case.get("residual_vcs"):
                raise JobError("case is not eligible for precondition refutation")
            if not case.get("vc", {}).get("manifest"):
                raise JobError(
                    "precondition refutation requires an original VC manifest"
                )
            _precondition_refutation_goal(case)
    output = output.resolve()
    if output.exists() and any(output.iterdir()):
        raise JobError("run certificate output must be empty")
    output.mkdir(parents=True, exist_ok=True)
    frozen = output / "automatic.json"
    frozen.write_text(json.dumps(report, indent=2) + "\n")
    entries = []
    for index, case in enumerate(results):
        if only_case_ids is not None and case["id"] not in only_case_ids:
            continue
        if not _eligible(case, decision_only=decision_only):
            continue
        vc = case.get("vc", {})
        if not vc.get("manifest") or not case.get("residual_vcs"):
            continue
        task = decision_itp_task(case, report["function"]) if decision_only else None
        explicit_refutation = case["id"] in refute_vcs or case["id"] in refute_preconditions
        if decision_only and task is None and not explicit_refutation:
            continue
        original = Path(vc["manifest"])
        manifest = json.loads(original.read_text())
        if (
            manifest.get("case_id") != case["id"]
            or manifest.get("function") != report["function"]
            or manifest.get("immutable_sha256") != vc.get("immutable_sha256")
            or manifest.get("residual_goals") != case["residual_vcs"]
            or manifest.get("coq_dependencies") != vc.get("coq_dependencies")
            or manifest.get("target_layout") != vc.get("target_layout")
            or manifest.get("target_layout") != case.get("target_layout")
            or manifest.get("qcip_root") != vc.get("qcip_root")
        ):
            raise JobError("VC manifest does not match automatic case")
        refute_entry = (
            _precondition_refutation_goal(case)
            if case["id"] in refute_preconditions
            else None
        )
        refute_vc = refute_vcs.get(case["id"])
        if refute_vc is not None and any(
            refute_vc == "proof_of_" + p.get("goal", "")
            for p in case.get("preconditions", [])
        ):
            raise JobError("use precondition refutation for an entry goal")
        refute = refute_entry or refute_vc
        origin = _decision_binding(case) if task and not refute else None
        selected = _decision_roots(case, task["goals"], origin) if task and not refute else None
        prepared = prepare_certificate(
            original, output / f"case_{index:04d}", refute=refute,
            only={refute} if refute is not None else selected,
        )
        bundle = json.loads(Path(prepared["manifest"]).read_text())
        statements = {g["statement"] for g in bundle["goals"]}
        proofs = {g["proof"] for g in bundle["goals"]}
        preconditions = case.get("preconditions", [])
        if refute is None and (
            not preconditions
            or any(
                p.get("status") not in {"SAT", "UNKNOWN"}
                or ((selected is None or p["status"] == "UNKNOWN") and p.get("goal") not in statements)
                for p in preconditions
            )
            # QCP may also report strategy-generated split goals. The complete
            # original interface contains their unsplit parent obligation.
            or any(not _residual_covered(name, proofs) for name in (task["goals"] if selected else case["residual_vcs"]))
        ):
            raise JobError(
                "certificate does not cover initial satisfiability and residual VCs"
            )
        entries.append(
            {
                "case_index": index,
                "selected_decision_roots": sorted(selected) if selected else None,
                "decision_parent_owners": {
                    root: owner for root, owner in origin[1].items()
                    if selected is None or root in selected
                } if origin is not None else {},
                "case_id": case["id"],
                "refute_precondition": refute_entry,
                "refute_vc": refute_vc,
                **prepared,
            }
        )
    request = {
        "schema": "qcp-spectest-run-certificate/v1",
        "automatic_sha256": digest(frozen),
        "decision_only": decision_only,
        "certificates": entries,
    }
    manifest_path = output / "run-manifest.json"
    manifest_path.write_text(json.dumps(request, indent=2) + "\n")
    return {
        "manifest": str(manifest_path),
        "manifest_sha256": digest(manifest_path),
        "proof_required": bool(entries),
        "editable": [e["editable"] for e in entries],
        "vc_groups": len(entries),
    }


def check_run_certificates(
    path: Path, expected_digest: str, *, switch="qcp-8.20", timeout=120, candidate_attempts=None
) -> dict:
    """Replay proofs ourselves; never merge agent-supplied certificate verdicts."""
    path = path.resolve()
    final_path = path.parent / "report.json"
    final_path.unlink(missing_ok=True)
    if digest(path) != expected_digest:
        raise JobError("run manifest differs from controller digest")
    request = json.loads(path.read_text())
    if request.get("schema") != "qcp-spectest-run-certificate/v1":
        raise JobError("unsupported run certificate manifest")
    frozen = path.parent / "automatic.json"
    if digest(frozen) != request["automatic_sha256"]:
        raise JobError("frozen automatic report changed")
    automatic = json.loads(frozen.read_text())
    result = copy.deepcopy(automatic)
    audits = []
    decision_only = request.get("decision_only", False)
    kernel_cache = KernelReplayCache() if candidate_attempts is None else None
    seen = set()
    for entry in request["certificates"]:
        index = entry["case_index"]
        if (
            type(index) is not int
            or index < 0
            or index >= len(result["results"])
            or index in seen
        ):
            raise JobError("invalid or duplicate certificate case")
        seen.add(index)
        case = result["results"][index]
        if case["id"] != entry["case_id"] or not _eligible(case, decision_only=decision_only):
            raise JobError("certificate target is not eligible for proof completion")
        refute = entry.get("refute_precondition")
        if refute is not None and refute != _precondition_refutation_goal(case):
            raise JobError("refutation target is not the original Require SAT VC")
        certificate = None
        attempts = candidate_attempts(entry) if candidate_attempts is not None else (None,)
        for record in attempts:
            certificate = check_certificate(
                Path(entry["manifest"]), entry["manifest_sha256"],
                switch=switch, timeout=timeout, kernel_cache=kernel_cache,
                measure_candidate_precheck=candidate_attempts is not None,
            )
            audits.append({"case_id": case["id"], "certificate": certificate})
            if record is not None:
                record(copy.deepcopy(certificate))
            if certificate.get("status") == "PASS" or (
                certificate.get("proof_status") == "VALID" and certificate.get("polarity") == "negative"
            ):
                break
        if certificate is None:
            raise JobError("proof controller provided no candidate")
        case.setdefault("original_residual_vcs", list(case["residual_vcs"]))
        refute_vc = entry.get("refute_vc")
        if refute_vc is not None:
            if refute is not None:
                raise JobError("conflicting certificate refutation targets")
            proved_invalid = (
                certificate.get("proof_status") == "VALID"
                and certificate.get("polarity") == "negative"
                and certificate.get("refuted_goal") == refute_vc
            )
            if not proved_invalid:
                continue
            case["automatic_status"] = case["status"]
            # A strategy may weaken a symbolic state. Refuting its VC proves
            # an invalid entailment, not reachability from the original Require.
            # Keep the execution verdict until a reachability certificate exists.
            case["reason"] = "vc_refuted_reachability_not_established"
            obligations = case.setdefault("vc_results", [])
            target = next((v for v in obligations if v.get("name") in {
                refute_vc, refute_vc.removeprefix("proof_of_")
            }), None)
            if target is None:
                target = {"kind": "original-vc", "name": refute_vc}
                obligations.append(target)
            target.update(status="INVALID", backend="rocq")
            case["residual_vcs"] = [
                name for name in case["residual_vcs"]
                if not _residual_covered(name, {refute_vc})
            ]
            case["vc"]["residual_goals"] = list(case["residual_vcs"])
            case["evidence"] = {
                "decision_backend": "qcp-smt+rocq",
                "certificate": "CHECKED_VC_REFUTATION",
                "vc_judgement": "VC_REFUTED",
                "execution_counterexample": "NOT_ESTABLISHED",
                "manifest_sha256": entry["manifest_sha256"],
                "refuted_goal": refute_vc,
            }
            continue
        proved_unsat = (
            refute is not None
            and certificate.get("proof_status") == "VALID"
            and certificate.get("polarity") == "negative"
            and certificate.get("refuted_goal") == refute
        )
        if not proved_unsat and (refute is not None or certificate["status"] != "PASS"):
            continue
        selected = entry.get("selected_decision_roots")
        previous_fail = case["status"] == "FAIL"
        case["automatic_status"] = case["status"]
        status = "FAIL" if proved_unsat or previous_fail else "PASS"
        if proved_unsat:
            reason = "precondition_refutation_checked"
            label = "CHECKED_PRECONDITION_REFUTATION"
        elif selected:
            reason = "decision_vcs_checked"
            label = "CHECKED_DECISION_VCS"
        else:
            reason = "complete_vc_certificate_checked"
            label = "CHECKED_COMPLETE_VC_GROUP"
        case.update(
            status=status,
            overall=status,
            satisfied=not (proved_unsat or previous_fail),
            reason=case["reason"] if previous_fail else reason,
        )
        case["phases"]["precondition"] = "UNSAT" if proved_unsat else "SAT"
        case["precondition_result"] = "UNSAT" if proved_unsat else "SAT"
        case["test_result"] = case["status"]
        if case["scope"] == "execution" and not proved_unsat:
            for phase in ("safety", "postcondition", "annotations"):
                if case["phases"][phase] == "UNKNOWN" and (not previous_fail or phase == "safety"):
                    case["phases"][phase] = "PASS"
        for precondition in case["preconditions"]:
            if selected and precondition["status"] != "UNKNOWN":
                continue
            precondition.update(
                status="UNSAT" if proved_unsat else "SAT", proof="kernel"
            )
        for i, obligation in enumerate(case.get("vc_results", [])):
            if proved_unsat:
                continue
            if decision_only:
                # Even a full-interface fallback proves parents, not every raw
                # diagnostic disjunct. Use only the audited printer associations.
                checked = [name for name, owner in entry.get("decision_parent_owners", {}).items()
                           if owner == i]
                if checked:
                    obligation["kernel_checked_parents"] = checked
            elif obligation["status"] != "INVALID":
                obligation.update(status="VALID", backend="rocq")
        case["residual_vcs"] = []
        if not selected:
            case["vc"]["automatic_status"] = case["vc"].get("status")
            case["vc"]["status"] = "certificate_refuted" if proved_unsat else "certificate_proved"
            case["vc"]["residual_goals"] = []
        case["evidence"] = {
            "decision_backend": "qcp-smt+rocq",
            "certificate": label,
            "manifest_sha256": entry["manifest_sha256"],
        }
        if selected:
            case["evidence"]["kernel_checked_goals"] = selected
        if proved_unsat:
            case["evidence"]["refuted_goal"] = refute
            case["evidence"]["initial_domain"] = "EMPTY"
    counts = Counter(c["status"] for c in result["results"])
    for status in CASE_STATUSES:
        result["summary"][status] = counts[status]
    pending = {c["id"]: c["residual_vcs"] for c in result["results"]
               if c.get("residual_vcs")}
    # A selected refutation can leave other goals pending in the same case.
    # Keep the original manifest as evidence, but dispatch only current goals.
    result["itp_vcs"] = [
        dict(v, goals=[g for g in v.get("goals", pending[v["case_id"]]) if g in pending[v["case_id"]]])
        for v in result.get("itp_vcs", []) if v["case_id"] in pending
    ]
    result["itp_vcs"] = [v for v in result["itp_vcs"] if v["goals"]]
    result["proof_completion"] = {
        "run_manifest_sha256": expected_digest,
        "automatic_report_sha256": request["automatic_sha256"],
        "status": "CHECKED" if audits else "SKIPPED_NO_ELIGIBLE_VCS",
        "certificates": audits,
        "wall_seconds": sum(a["certificate"]["duration_seconds"] for a in audits),
    }
    result["summary"]["proof_wall_seconds"] = result["proof_completion"]["wall_seconds"]
    result["report"] = str(final_path)
    final_path.write_text(json.dumps(result, indent=2) + "\n")
    return result
