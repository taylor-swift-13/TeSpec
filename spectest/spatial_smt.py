"""Optional post-execution spatial VC decision stage with immutable ITP fallback.

This consumes copy-only path VCs after native execution. It never resumes an
interrupted execution or changes the original executor/Coq artifacts.
"""

from __future__ import annotations

from copy import deepcopy
from collections import Counter
import hashlib
import json
from pathlib import Path
import re
import time

from .modes import EXECUTION_SEMANTICS, normalize_execution_mode


def _solve_record(record: dict, timeout_ms: int) -> dict:
    # Do not import Z3 when this feature is disabled (or for existing decisions).
    from tools.finite_spatial_smt.finite_spatial_smt import check, Unsupported
    from tools.finite_spatial_smt.qcp_import import import_record

    try:
        vc = import_record(
            record, check_mode=record.get("check_mode"),
            local_semantics=record.get("local_semantics"),
        )
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



def _checked_contract_samples(case: dict, native: dict) -> bool:
    """Admit completed contract samples, with the native validation provenance.

    This does not certify the external implementation or generate new samples.
    Loop/assertion sampling has separate obligation coverage and remains outside
    this adapter. Every accepted finite VC retains its contract-model scope.
    """
    strategy = native.get("execution_strategy")
    if (
        not isinstance(strategy, str) or strategy not in EXECUTION_SEMANTICS
        or case.get("execution_strategy") != strategy
        or native.get("execution_semantics") != EXECUTION_SEMANTICS[strategy]
        or case.get("execution_semantics") != EXECUTION_SEMANTICS[strategy]
        or native.get("result_scope") != "contract-and-invariant-model"
        or case.get("result_scope") != "contract-and-invariant-model"
        or native.get("declaration_call_policy") != "contract-sample/v1"
        or case.get("declaration_call_policy") != "contract-sample/v1"
        or native.get("completed") is not True
        or native.get("scope") != "execution"
        or native.get("annotation_policy") != case.get("annotation_policy")
    ):
        return False
    try:
        if normalize_execution_mode(native.get("mode")) != case.get("mode"):
            return False
    except ValueError:
        return False
    samples = native.get("sampling_events")
    events = native.get("abstraction_events")
    if (
        not isinstance(samples, list) or not samples
        or samples != case.get("sampling_events")
        or not isinstance(events, list) or not events
        or events != case.get("abstraction_events")
    ):
        return False
    sampled_counts = Counter()
    for sample in samples:
        if (
            not isinstance(sample, dict)
            or not isinstance(sample.get("kind"), str)
            or sample["kind"] not in {"contract-prestate", "contract"}
            or sample.get("status") != "SAMPLED"
            or sample.get("policy") != "deterministic-bounds-v1"
            or type(sample.get("attempt")) is not int or sample["attempt"] <= 0
            or any(not isinstance(sample.get(key), str) or not sample[key].strip()
                   for key in ("constraint_state", "selected_state"))
        ):
            return False
        sampled_counts[sample["kind"]] += 1
    if sampled_counts["contract"] == 0:
        return False
    counts = Counter()
    calls = 0
    seen = set()
    for event in events:
        if not isinstance(event, dict) or set(event) != {"kind", "function", "count"}:
            return False
        kind, function, count = event["kind"], event["function"], event["count"]
        if (
            not isinstance(kind, str) or not isinstance(function, str) or not function
            or type(count) is not int or count <= 0
            or (kind, function) in seen
        ):
            return False
        seen.add((kind, function))
        if kind == "contract-sample":
            calls += count
        elif kind == "contract_state_sampled" and function in {"contract-prestate", "contract"}:
            counts[function] += count
        elif kind == "infeasible-call-input":
            # Native emits this only when AssertionSatisfiability proves the
            # incoming state UNSAT, before applying the callee's contract.
            # This branch has no sampled successor and contributes no VC.
            continue
        else:
            return False
    return counts == sampled_counts and calls == sampled_counts["contract"]


def _checked_events(case: dict, native: dict, function: str) -> bool:
    """Admit unchanged concrete traces or validated contract-only samples."""
    if (
        native.get("execution_semantics") == "modular-sampled/v1"
        or native.get("sampling_events") or case.get("sampling_events")
        or native.get("result_scope") == "contract-and-invariant-model"
    ):
        return _checked_contract_samples(case, native)
    events = case.get("abstraction_events", [])
    if not events:
        return not native.get("abstraction_events")
    if (
        not isinstance(events, list)
        or native.get("abstraction_events") != events
        or native.get("completed") is not True
        or native.get("scope") != "execution"
        or native.get("mode") != "no-expand"
        or native.get("annotation_policy") != "check-preserve"
        or case.get("mode") != "all-boundaries"
        or case.get("annotation_policy") != "check-preserve"
    ):
        return False
    calls = Counter()
    contracts = Counter()
    seen = set()
    for event in events:
        if not isinstance(event, dict) or set(event) != {"kind", "function", "count"}:
            return False
        kind, fn, count = event["kind"], event["function"], event["count"]
        if (
            kind not in {"annotation-check", "inline-call", "contract-check"}
            or not isinstance(fn, str) or not fn
            or type(count) is not int or count <= 0
            or (kind, fn) in seen
        ):
            return False
        seen.add((kind, fn))
        if kind == "annotation-check" and fn != function:
            return False
        if kind == "inline-call":
            calls[fn] += count
        elif kind == "contract-check":
            contracts[fn] += count
    return calls == contracts


def _annotation_coverage(executor: dict, case: dict, original: list) -> bool:
    """Check a complete, unambiguous return/annotation residual group.

    This is execution-decision coverage, not a Coq certificate. Native diagnostic
    VCs have no stable IDs, so admit only one function, one path per source line,
    and unsuffixed witness roots. Mixed, branched or unmapped inventories retain
    ITP. Every UNKNOWN VC in the accepted group must still be decided separately.
    """
    native = executor.get("spec_test", {})
    if (
        native.get("mode") != "no-expand"
        or native.get("annotation_policy") != "check-preserve"
        or case.get("mode") != "all-boundaries"
        or case.get("annotation_policy") != "check-preserve"
        or native.get("completed") is not True
        or native.get("scope") != "execution"
    ):
        return False
    families = {"return": "return_checker_wit", "entailment": "entailment_checker_wit"}
    unknown = [v for v in original if v.get("status") == "UNKNOWN"]
    if not any(v.get("kind") == "entailment" for v in unknown):
        return False
    if any(v.get("kind") not in families for v in unknown):
        return False
    fn = executor.get("functionName")
    manual = executor.get("manual_obligations")
    witnesses = executor.get("WitnessList")
    if (
        not isinstance(fn, str) or not fn
        or not isinstance(manual, list) or not manual
        or executor.get("manual_obligation_count") != len(manual)
        or len(manual) != len(unknown)
        or not isinstance(witnesses, list) or len(witnesses) != 1
        or witnesses[0].get("functionName") != fn
    ):
        return False
    keys = [(families[v["kind"]], v.get("line")) for v in unknown]
    if any(type(line) is not int or line <= 0 for _, line in keys):
        return False
    if len(set(keys)) != len(keys):
        return False
    if any(m.get("functionName") != fn for m in manual):
        return False
    if Counter(keys) != Counter((m.get("kind"), m.get("line")) for m in manual):
        return False
    filenames = {m.get("fileName") for m in manual}
    if len(filenames) != 1 or not all(isinstance(f, str) and f for f in filenames):
        return False
    witness = witnesses[0].get("Witness", {})
    totals = {}
    for kind, family in families.items():
        records = [v for v in original if v.get("kind") == kind]
        pending = [m for m in manual if m.get("kind") == family]
        counts = witness.get(family, {})
        if (
            counts.get("total") != len(records)
            or counts.get("manual") != len(pending)
            or counts.get("auto_solved") != len(records) - len(pending)
        ):
            return False
        listed = counts.get("manual_witness") or []
        def signature(item):
            return tuple(item.get(k) for k in ("line", "column", "fileName", "goal"))
        if Counter(map(signature, listed)) != Counter(map(signature, pending)):
            return False
        totals[kind] = counts["total"]
    for family, counts in witness.items():
        if family not in families.values() and family != "total_witness_count":
            if not isinstance(counts, dict) or counts.get("manual") != 0:
                return False
    if witness.get("total_witness_count", {}).get("manual") != len(manual):
        return False
    residual = case.get("residual_vcs")
    if not isinstance(residual, list) or not residual or len(set(residual)) != len(residual):
        return False
    pattern = re.compile(
        r"proof_of_" + re.escape(fn)
        + r"_(return|entail)_wit_([1-9][0-9]*)(?P<split>_split_goal_[A-Za-z0-9_]+)?\Z"
    )
    roots = {"return": set(), "entailment": set()}
    wrappers = set()
    for goal in residual:
        match = pattern.fullmatch(goal) if isinstance(goal, str) else None
        if not match:
            return False
        kind = "entailment" if match[1] == "entail" else "return"
        index = int(match[2])
        if index > totals[kind]:
            return False
        root = (kind, index)
        roots[kind].add(root)
        if not match["split"]:
            wrappers.add(root)
    for kind, family in families.items():
        if len(roots[kind]) != sum(m.get("kind") == family for m in manual):
            return False
        if not roots[kind] <= wrappers:
            return False
    return True


def _annotation_artifacts(case: dict, executor: dict) -> dict:
    """Bind group coverage to generated declarations, without proving Coq lemmas."""
    manifest = case.get("vc", {})
    if (manifest.get("schema") != "qcp-spectest-vc-manifest/v1"
            or manifest.get("status") != "residual" or manifest.get("missing_files")
            or manifest.get("function") != executor.get("functionName")
            or not case.get("id") or manifest.get("case_id") != case.get("id")
            or executor.get("spec_test", {}).get("target_layout") != case.get("target_layout")
            or manifest.get("target_layout") != case.get("target_layout")
            or manifest.get("residual_goals") != case.get("residual_vcs")):
        raise ValueError("missing_or_mismatched_residual_manifest")
    source = case.get("generated_source")
    if (not source or manifest.get("source") != source or executor.get("fileName") != source
            or hashlib.sha256(Path(source).read_bytes()).hexdigest() != case.get("generated_source_sha256")):
        raise ValueError("generated_source_binding_mismatch")
    saved = json.loads(Path(manifest["manifest"]).read_text())
    for key in ("files", "immutable_sha256", "residual_goals", "function", "case_id", "source", "target_layout"):
        if saved.get(key) != manifest.get(key):
            raise ValueError("residual_manifest_changed:" + key)
    files, texts, hashes = manifest["files"], {}, {}
    for kind in ("goal", "proof_auto", "proof_manual", "goal_check"):
        data = Path(files[kind]).read_bytes()
        texts[kind] = data.decode("utf-8")
        hashes[kind] = hashlib.sha256(data).hexdigest()
        if kind != "proof_manual" and hashes[kind] != manifest["immutable_sha256"].get(kind):
            raise ValueError("original_coq_file_changed:" + kind)
    declarations = re.findall(r"^Definition\s+(\w+)\s*:=", texts["goal"], re.M)
    if len(set(declarations)) != len(declarations):
        raise ValueError("duplicate_goal_definition")
    def proofs(kind):
        found = re.findall(r"^(?:Lemma|Theorem)\s+(proof_of_\w+)\s*:\s*(\w+)\s*\.", texts[kind], re.M)
        names = [name for name, _ in found]
        if len(set(names)) != len(names):
            raise ValueError("duplicate_proof_declaration")
        if any(name != "proof_of_" + target or target not in declarations for name, target in found):
            raise ValueError("proof_target_definition_mismatch")
        return set(names)
    manual, automatic = proofs("proof_manual"), proofs("proof_auto")
    if manual != set(case["residual_vcs"]) or manual & automatic:
        raise ValueError("manual_residual_inventory_mismatch")
    interfaces = re.findall(r"^Axiom\s+(proof_of_\w+)\s*:\s*(\w+)\s*\.", texts["goal"], re.M)
    interface_names = [name for name, _ in interfaces]
    if len(set(interface_names)) != len(interface_names):
        raise ValueError("duplicate_interface_root")
    if any(name != "proof_of_" + target or target not in declarations for name, target in interfaces):
        raise ValueError("interface_target_mismatch")
    roots = {name for name in manual if "_split_goal_" not in name}
    if not roots <= set(interface_names) or set(interface_names) - automatic != roots:
        raise ValueError("uncovered_interface_root")
    goal_module = Path(files["goal"]).stem
    auto_module, manual_module = Path(files["proof_auto"]).stem, Path(files["proof_manual"]).stem
    expected = (f"Require Import {goal_module} {auto_module} {manual_module}. "
                f"Module VC_Correctness : VC_Correct. Include {auto_module}. "
                f"Include {manual_module}. End VC_Correctness.")
    if " ".join(texts["goal_check"].split()) != expected:
        raise ValueError("unsupported_goal_check_interface")
    return {"scope": "original-obligation-group/v1", "files": files,
            "sha256": hashes, "interface_roots": sorted(roots),
            "auxiliary_split_lemmas_individually_proved": False,
            "certificate": "NOT_CHECKED"}

def refine_case(
    case: dict, stdout_path: Path, artifact_dir: Path, *, timeout_ms: int
) -> None:
    """Refine supported UNKNOWN VCs; leave all original proof files intact."""
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
        "result_scope": case.get("result_scope"),
    }
    case["spatial_smt"] = info
    # Never turn executor errors, incomplete executions or entry uncertainty
    # into a counterexample. Contract samples retain their explicit model scope.
    if (
        case.get("status") != "UNKNOWN"
        or case.get("scope") != "execution"
        or case.get("execution_completed") is not True
        or case.get("precondition_result") != "SAT"
        or case.get("executor_error")
        or case.get("returncode") != 0
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
            or native.get("execution_semantics") not in EXECUTION_SEMANTICS.values()
            or native.get("result_semantics") != "three-valued-conjunction/v1"
            or native.get("limit_reason")
            or native.get("vc_results") != case.get("vc_results")
        ):
            info["reason"] = "unsupported_executor_protocol"
            return
    except (OSError, ValueError, KeyError, TypeError, AttributeError) as error:
        info["reason"] = "executor_artifact_unavailable:" + str(error)
        return
    if not _checked_events(case, native, executor.get("functionName")):
        info["reason"] = "unsupported_execution_events"
        return
    original = case["vc_results"]
    contract_samples = bool(native.get("sampling_events"))
    if contract_samples:
        info["sampling_events_sha256"] = hashlib.sha256(
            json.dumps(native["sampling_events"], sort_keys=True).encode()
        ).hexdigest()
        info["execution_strategy"] = native["execution_strategy"]
    try:
        annotation_coverage = (not contract_samples
                               and _annotation_coverage(executor, case, original))
    except (TypeError, AttributeError, KeyError, ValueError):
        annotation_coverage = False
    if annotation_coverage:
        try:
            info["annotation_artifact_binding"] = _annotation_artifacts(case, executor)
        except (OSError, ValueError, TypeError, KeyError, AttributeError) as error:
            annotation_coverage = False
            info["annotation_coverage_reason"] = "original_artifact_binding_failed:" + str(error)
    else:
        info["annotation_coverage_reason"] = "unsupported_or_ambiguous_obligation_group"
    info["annotation_residual_coverage"] = annotation_coverage
    refined = deepcopy(original)
    artifact_dir.mkdir(parents=True, exist_ok=True)
    info["executor_sha256"] = hashlib.sha256(raw_bytes).hexdigest()
    for index, obligation in enumerate(original):
        if obligation.get("status") != "UNKNOWN":
            continue
        record = {"layout": case.get("target_layout"), "vc": obligation}
        if obligation.get("kind") == "entailment" and annotation_coverage:
            record.update(check_mode="exact", local_semantics="same-program-environment/v1")
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
    annotations = [v for v in refined if v.get("kind") == "entailment"]
    if annotation_coverage and annotations:
        if any(v["status"] == "INVALID" for v in annotations):
            phases["annotations"] = "FAIL"
        elif all(v["status"] == "VALID" for v in annotations):
            phases["annotations"] = "PASS"
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
    coverage = coverage or annotation_coverage
    info["residual_coverage"] = coverage
    status = case["status"]
    if "INVALID" in states:
        status = "FAIL"
        case["reason"] = "spatial_smt_invalid_path_vc"
    elif states and all(s == "VALID" for s in states) and complete and coverage:
        status = "PASS"
        case["reason"] = "spatial_smt_valid_path_vcs"
    case["phases"] = phases
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
