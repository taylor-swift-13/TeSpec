"""Controller-owned reconciliation of automatic runs and complete VC proofs."""

from __future__ import annotations

from collections import Counter
import copy
import json
from pathlib import Path
import re

from .certificates import check_certificate, digest, prepare_certificate
from .core import JobError
from .kernel_replay import KernelReplayCache


def _eligible(case: dict) -> bool:
    if (
        case.get("status") != "UNKNOWN"
        or case.get("reason")
        not in {"precondition_requires_proof", "residual_vc_requires_proof"}
        or case.get("executor_error")
        or case.get("execution_semantics") != "inline-preserve/v1"
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
        and all(
            phases.get(k) in {"PASS", "UNKNOWN", "NOT_CHECKED", "NOT_RUN"}
            for k in ("safety", "postcondition", "annotations")
        )
        and phases.get("safety") in {"PASS", "UNKNOWN"}
        and phases.get("postcondition") in {"PASS", "UNKNOWN"}
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


def prepare_run_certificates(
    report_path: Path, output: Path, *, refute_preconditions: set[str] | None = None,
    refute_vcs: dict[str, str] | None = None,
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
    for case in results:
        if case["id"] in refute_vcs and not _eligible(case):
            raise JobError("case is not eligible for VC refutation")
        if case["id"] in refute_preconditions:
            if not _eligible(case) or not case.get("residual_vcs"):
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
        if not _eligible(case):
            continue
        vc = case.get("vc", {})
        if not vc.get("manifest") or not case.get("residual_vcs"):
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
        prepared = prepare_certificate(
            original, output / f"case_{index:04d}", refute=refute,
            only={refute} if refute is not None else None,
        )
        bundle = json.loads(Path(prepared["manifest"]).read_text())
        statements = {g["statement"] for g in bundle["goals"]}
        proofs = {g["proof"] for g in bundle["goals"]}
        preconditions = case.get("preconditions", [])
        if refute is None and (
            not preconditions
            or any(
                p.get("status") not in {"SAT", "UNKNOWN"}
                or p.get("goal") not in statements
                for p in preconditions
            )
            # QCP may also report strategy-generated split goals. The complete
            # original interface contains their unsplit parent obligation.
            or any(not _residual_covered(name, proofs) for name in case["residual_vcs"])
        ):
            raise JobError(
                "certificate does not cover initial satisfiability and residual VCs"
            )
        entries.append(
            {
                "case_index": index,
                "case_id": case["id"],
                "refute_precondition": refute_entry,
                "refute_vc": refute_vc,
                **prepared,
            }
        )
    request = {
        "schema": "qcp-spectest-run-certificate/v1",
        "automatic_sha256": digest(frozen),
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
    path: Path, expected_digest: str, *, switch="qcp-8.20", timeout=120
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
    kernel_cache = KernelReplayCache()
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
        if case["id"] != entry["case_id"] or not _eligible(case):
            raise JobError("certificate target is not eligible for proof completion")
        refute = entry.get("refute_precondition")
        if refute is not None and refute != _precondition_refutation_goal(case):
            raise JobError("refutation target is not the original Require SAT VC")
        certificate = check_certificate(
            Path(entry["manifest"]),
            entry["manifest_sha256"],
            switch=switch,
            timeout=timeout,
            kernel_cache=kernel_cache,
        )
        audits.append({"case_id": case["id"], "certificate": certificate})
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
        case["automatic_status"] = case["status"]
        case.update(
            status="FAIL" if proved_unsat else "PASS",
            overall="FAIL" if proved_unsat else "PASS",
            satisfied=False if proved_unsat else True,
            reason="precondition_refutation_checked"
            if proved_unsat
            else "complete_vc_certificate_checked",
        )
        case["phases"]["precondition"] = "UNSAT" if proved_unsat else "SAT"
        case["precondition_result"] = "UNSAT" if proved_unsat else "SAT"
        case["test_result"] = "FAIL" if proved_unsat else "PASS"
        if case["scope"] == "execution" and not proved_unsat:
            for phase in ("safety", "postcondition", "annotations"):
                if case["phases"][phase] not in {"NOT_CHECKED", "NOT_RUN"}:
                    case["phases"][phase] = "PASS"
        for precondition in case["preconditions"]:
            precondition.update(
                status="UNSAT" if proved_unsat else "SAT", proof="kernel"
            )
        for obligation in case.get("vc_results", []):
            if not proved_unsat:
                obligation["status"] = "VALID"
                obligation["backend"] = "rocq"
        case["residual_vcs"] = []
        case["vc"]["automatic_status"] = case["vc"].get("status")
        case["vc"]["status"] = (
            "certificate_refuted" if proved_unsat else "certificate_proved"
        )
        case["vc"]["residual_goals"] = []
        case["evidence"] = {
            "decision_backend": "qcp-smt+rocq",
            "certificate": "CHECKED_PRECONDITION_REFUTATION"
            if proved_unsat
            else "CHECKED_COMPLETE_VC_GROUP",
            "manifest_sha256": entry["manifest_sha256"],
        }
        if proved_unsat:
            case["evidence"]["refuted_goal"] = refute
            case["evidence"]["initial_domain"] = "EMPTY"
    counts = Counter(c["status"] for c in result["results"])
    for status in ("PASS", "FAIL", "UNKNOWN", "ERROR", "INVALID"):
        result["summary"][status] = counts[status]
    pending = {c["id"] for c in result["results"] if c.get("residual_vcs")}
    result["itp_vcs"] = [
        v for v in result.get("itp_vcs", []) if v["case_id"] in pending
    ]
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
