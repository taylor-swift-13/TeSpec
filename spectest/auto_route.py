"""Independent automatic decisions for the same residuals presented to ITP."""
from collections import Counter
from copy import deepcopy
import hashlib
import json
from pathlib import Path
import re
import time

from .core import JobError, _consume_balanced, _safe_case_id
from .itp_schedule import bind_proof_roots
from .rocq_predicates import _strip_outer_parens
from .spatial_smt import _checked_events, _has_unmapped_local_scope, _obligation_artifacts, _refine_records, _solve_record
from .verdict import CASE_STATUSES, _executor_result


def _checked_c_source(case):
    source = Path(case["generated_source"]).read_bytes()
    if hashlib.sha256(source).hexdigest() != case["generated_source_sha256"]:
        raise ValueError("generated_source_changed")
    return source.decode()


def _value_aggregate_parameters(source, layout, function):
    """Identify aggregate parameters copied into the callee's private frame."""
    from .core import _c_parameters, _function_specs

    specs = _function_specs(source, function)
    aliases = {a["name"] for a in layout.get("aliases", [])
               if a.get("type", {}).get("kind") in {"struct", "union"}}
    aggregates = set()
    for spec in specs:
        for parameter in _c_parameters(spec):
            if parameter.pointer_like:
                continue
            typ = set(re.findall(r"[A-Za-z_]\w*", parameter.declaration)) - {parameter.name}
            if typ & ({"struct", "union"} | aliases):
                aggregates.add(parameter.name)
    return aggregates


def _missing_value_parameter_cells(aggregates, goal, root):
    if not aggregates:
        return []
    name = re.escape(root.removeprefix("proof_of_"))
    definition = re.search(r"(?ms)^Definition\s+" + name + r"\s*:=\s*(.*?)\.(?=\s|$)",
                           goal)
    if not definition:
        return []
    def cell_offsets(formula, param):
        result = set()
        for cell in re.finditer(r"#\s*\w+\s*\|->", formula):
            address = formula[:cell.start()].rstrip()
            if address.endswith(")"):
                balance = 0
                for index in range(len(address) - 1, -1, -1):
                    balance += (address[index] == ")") - (address[index] == "(")
                    if balance == 0:
                        address = _strip_outer_parens(address[index:]).strip()
                        break
            else:
                atom = re.search(r"[\w']+$", address)
                address = atom[0] if atom else ""
            match = re.fullmatch(re.escape(param) + r"(?:\s*\+\s*(\d+))?", address)
            if match:
                result.add(int(match[1] or 0))
        return result

    missing = set()
    for arm in re.split(r"(?m)^\)\s*\\/\s*\(\s*$", definition[1]):
        if arm.count("|--") != 1:
            continue
        lhs, rhs = arm.split("|--")
        for param in aggregates:
            # Compare printer-emitted byte offsets, not a guess about null or
            # aliasing. Only the address of the parameter object is private.
            if cell_offsets(rhs, param) - cell_offsets(lhs, param):
                missing.add(param)
    return sorted(missing)


def _partial_return_temporary(ir, source):
    """An exact-heap mismatch on a partially retained internal result object."""
    if ir.get("mode") != "exact" or len(ir.get("pre", [])) != 1 or not ir.get("post"):
        return []
    # QCP's NewRecordReturnAddr uses an anonymous "record_return" logic
    # variable. A user declaration with the same spelling is ambiguous.
    if re.search(r"\brecord_return(?:_\d+)*(?:_free)?\b", source):
        return []

    def fields(branch):
        result = {}
        for cell in branch.get("spatial", []):
            if cell.get("kind") != "cell":
                continue
            address = _strip_outer_parens(cell["address"].strip())
            m = re.fullmatch(r"(record_return_\d+_free)(?:\s*\+\s*(\d+))?", address)
            if m:
                result.setdefault(m[1], set()).add((int(m[2] or 0), cell["type"]))
        return result

    before = fields(ir["pre"][0])
    if not before:
        return []
    after = [fields(branch) for branch in ir["post"]]
    return sorted(base for base, owned in before.items()
                  if all(set() < branch.get(base, set()) < owned for branch in after))


def _same_counterexample(goal, root, nonempty, timeout_ms):
    """A negative raw disjunct need not refute the original alternative.

    For the common printer form, a raw counterexample also refutes the other
    implication when its guard is equivalent, its antecedent heap is identical and
    its post is identical or all alternatives demand an empty heap violated by the witness.
    """
    target = re.escape(root.removeprefix("proof_of_"))
    match = re.search(r"^Definition\s+" + target + r"\s*:=\s*(.*?)\.\s*$", goal, re.S | re.M)
    if not match:
        return False
    text = match[1]
    if "\\/" not in text:
        return True
    arms = re.split(r"^\)\s*\\/\s*\(\s*$", text, flags=re.M)
    if len(arms) < 2 or any("\\/" in arm for arm in arms):
        return False
    arms[0] = arms[0].strip().removeprefix("(")
    arms[-1] = arms[-1].strip().removesuffix(")")
    from tools.finite_spatial_smt.finite_spatial_smt import Expressions, boolean, z3

    def parse_arm(arm):
        quantifiers, formula = arm.strip().removeprefix("forall ").split(",", 1)
        # Only first-order Z variables and the printer's atomic pure guards.
        rest = quantifiers.strip()
        names, guards = set(), []
        expr = Expressions()
        while rest:
            binder, end = _consume_balanced(rest, 0, "(", ")")
            rest = rest[end:].strip()
            name, typ = (part.strip() for part in binder.split(":", 1))
            if not re.fullmatch(r"\w+", name):
                raise ValueError("unsupported_parent_binder")
            if typ == "Z":
                names.add(name)
            else:
                if not name.startswith("PreH"):
                    raise ValueError("unsupported_parent_binder")
                if not re.fullmatch(r"[a-zA-Z0-9_() <>+=*-]+", typ):
                    raise ValueError("unsupported_parent_arithmetic")
                guards.append(boolean(expr.parse(re.sub(r"(?<![<>=!])=(?!=)", "==", typ.replace("<>", "!=")))))
        if set(expr.variables) - names:
            raise ValueError("unbound_parent_guard")
        pre, post = formula.split("|--")
        return names, z3.And(*guards), " ".join(pre.split()), " ".join(post.split())

    try:
        variables, base, pre, post = parse_arm(arms[0])
        for arm in arms[1:]:
            names, cond, lhs, rhs = parse_arm(arm)
            if variables != names or pre != lhs:
                return False
            empty_requirement = r"(?:(?:TT|“[^”]+”)\s*&&\s*)*emp"
            if post != rhs and not (nonempty and re.fullmatch(empty_requirement, post)
                                    and re.fullmatch(empty_requirement, rhs)):
                return False
            s = z3.Solver()
            s.set(timeout=timeout_ms)
            s.add(z3.Xor(base, cond))
            if s.check() != z3.unsat:
                return False
        return True
    except (ValueError, TypeError, RecursionError, z3.Z3Exception):
        return False


def _solve_auto_record(record, case, budget, compiled_names, ground_cache=None):
    # A native scalar parser can treat a bare imported Coq constant as a
    # free integer. Consult its bound definition before that interpretation.
    vc = record["vc"]
    mentions_import = compiled_names and any(
        name in compiled_names for name in re.findall(r"[A-Za-z_][A-Za-z0-9_']*", vc["path"] + "\n" + vc["goal"])
    )
    if not mentions_import:
        from .auto_frame_evidence import check_auto_heap
        decision = _solve_record(record, budget, checker=check_auto_heap)
        if decision["status"] != "UNKNOWN" or decision.get("supported") is not False:
            return decision
    from .auto_definitions import solve_path
    decision = solve_path(record, case, timeout_ms=budget, ground_cache=ground_cache)
    if decision["status"] == "UNKNOWN" and decision["reason"].startswith("unbound_definition_at_declaration:"):
        from .auto_common_frame import prove_with_common_frame

        name = decision["reason"].split(":", 1)[1]
        framed = prove_with_common_frame(
            record, case, name,
            lambda remainder: solve_path(remainder, case, timeout_ms=budget, ground_cache=ground_cache),
        )
        if framed is not None:
            decision = framed
    if (decision["status"] == "INVALID" and vc["kind"] in {"entailment", "which_implies"}
            and _has_unmapped_local_scope(vc)):
        decision.update(status="UNKNOWN", reason="unmapped_local_stack_frame")
    return decision


def _auto_case(case, function, output, timeout_ms):
    raw = Path(case["stdout"]).read_bytes()
    executor = json.loads(raw)
    native = executor["spec_test"]
    info = case["auto_route"]
    info["executor_sha256"] = hashlib.sha256(raw).hexdigest()
    original = case["vc_results"]
    original_status = case["status"]
    baseline = _executor_result(raw.decode(), case["returncode"], case["vc"],
                                expected_strategy=case.get("execution_strategy"))
    for key in ("status", "reason", "vc_results", "preconditions", "execution_completed",
                "precondition_result", "phases", "target_layout", "scope", "residual_vcs",
                "sampling_events", "abstraction_events", "execution_semantics", "mode"):
        if baseline.get(key) != case.get(key):
            raise ValueError("native_result_mismatch:" + key)
    if (executor.get("functionName") != function or case.get("executor_error") or
            native.get("limit_reason") or native.get("vc_semantics") != "path-vc/v1" or
            native.get("query_semantics") != "copy-only/v1" or
            native.get("result_semantics") != "three-valued-conjunction/v1" or
            case["returncode"] not in (0, 3) or
            (case["returncode"] == 3 and native.get("overall") != "UNKNOWN") or
            "--precondition-proof-negation" in case.get("command", [])):
        raise ValueError("unsupported_native_decision_context")
    execution = case["scope"] == "execution"
    if execution and (not case["execution_completed"] or not native.get("completed") or
                      case["phases"]["execution"] != "PASS" or not _checked_events(case, native, function)):
        raise ValueError("incomplete_execution_or_unbound_events")
    if not execution and case["scope"] != "specification-only":
        raise ValueError("unknown_scope")
    binding = _obligation_artifacts(case, executor)
    manifest = case["vc"]
    saved = json.loads(Path(manifest["manifest"]).read_bytes())
    if any(saved.get(key) != manifest.get(key) for key in ("coq_dependencies", "generated_coq_dependencies", "opaque_imports", "runtime_dependencies", "qcip_root")):
        raise ValueError("mismatched_definition_context")
    roots = set(binding["interface_roots"])
    # Older reports without printer identities cannot establish which raw
    # countermodel belongs to which parent, even if their line numbers match.
    owners = bind_proof_roots(function, original, binding)
    info["original_goal_sha256"] = binding["sha256"]["goal"]
    entry_roots = {"proof_of_" + p["goal"] for p in case["preconditions"] if p.get("status") == "UNKNOWN"}
    entry = case["precondition_result"]
    if entry == "UNKNOWN" and entry_roots and entry_roots <= roots:
        from .auto_definitions import solve_entry
        result = solve_entry(case, executor, binding, timeout_ms=timeout_ms)
        info["entry"] = result
        if (result.get("status") in {"SAT", "UNSAT"} and
                set(result.get("targets", [])) == entry_roots and
                (result["status"] == "SAT" or len(case["preconditions"]) == 1)):
            entry = result["status"]
            for p in case["preconditions"]:
                if p["status"] == "UNKNOWN":
                    p.update(status=entry, proof="auto-spatial-smt")
            case["precondition_result"] = case["phases"]["precondition"] = entry
    from .auto_definitions import frozen_bytes
    from .opaque_imports import checked_names, original_interface, passive_declarations
    compiled_names = set()
    for dep in manifest["coq_dependencies"]:
        name = dep["module"]
        raw = frozen_bytes(dep["staged"], dep["sha256"])
        interface = manifest.get("opaque_imports", {}).get(name)
        if interface is None and original:
            interface = original_interface(name, raw, manifest)
        if interface is not None:
            compiled_names.update(checked_names(raw, interface))
        else:
            # A declared constant still cannot be interpreted as a free integer
            # just because its executable interface is unavailable.
            compiled_names.update(passive_declarations(raw.decode("utf-8")))

    ground_cache = {}

    def solve(record, budget):
        return _solve_auto_record(record, case, budget, compiled_names, ground_cache)

    refined = _refine_records(original, case["target_layout"], output, timeout_ms, solve, info)
    case["vc_results"] = refined
    resolved_entries = entry_roots if entry == "SAT" else set()
    covered = set(owners) | resolved_entries
    unknown = {i for i, vc in enumerate(original) if vc["status"] == "UNKNOWN"}
    coverage = covered == roots and unknown <= set(owners.values())
    info["parent_coverage"] = coverage
    phases = case["phases"]
    by_phase = {"safety": {"safety"}, "postcondition": {"return"}, "annotations": {"entailment", "which_implies"}}
    states = [vc["status"] for vc in refined]
    status, reason = original_status, case["reason"]
    if entry == "UNSAT":
        status, reason = "FAIL", "bindings_violate_require"
    elif entry == "SAT" and coverage:
        for phase, kinds in by_phase.items():
            members = [v["status"] for v in refined if v["kind"] in kinds]
            if members and all(s == "VALID" for s in members) and phases[phase] == "UNKNOWN":
                phases[phase] = "PASS"
        # Native confirmed failures retain precedence unless a mapped safety VC
        # supplies a higher-priority fault. A countermodel of a helper or just
        # one arm of the parent is diagnostic only.
        disproved = set()
        goal_bytes = Path(binding["files"]["goal"]).read_bytes()
        if hashlib.sha256(goal_bytes).hexdigest() != binding["sha256"]["goal"]:
            raise ValueError("original_goal_changed")
        goal = goal_bytes.decode()
        frame_context = source = None
        checked_call = any(e["kind"] == "contract-check" for e in case.get("abstraction_events", []))
        for root, i in owners.items():
            if i not in unknown or refined[i]["status"] != "INVALID":
                continue
            decision = json.loads(Path(refined[i]["spatial_smt"]["artifact"]).read_bytes())
            kind = refined[i]["kind"]
            if kind in {"return", "entailment", "which_implies"} and _has_unmapped_local_scope(original[i]):
                continue
            if kind == "return" or (kind == "entailment" and checked_call):
                if source is None:
                    source = _checked_c_source(case)
            if kind == "entailment" and checked_call:
                partial = _partial_return_temporary(decision.get("normalized_vc", {}), source)
                if partial:
                    info.setdefault("writeback_diagnostics", []).append({
                        "root": root, "vc_index": i, "temporaries": partial,
                        "reason": "partial_internal_return_temporary",
                    })
                    continue
            if kind == "return":
                if frame_context is None:
                    from .certificates import strip_comments
                    params = _value_aggregate_parameters(source, case["target_layout"], function)
                    frame_context = (params, strip_comments(goal) if params else "")
                missing = _missing_value_parameter_cells(*frame_context, root)
                if missing:
                    info.setdefault("writeback_diagnostics", []).append({
                        "root": root, "vc_index": i, "parameters": missing,
                        "reason": "missing_by_value_parameter_frame",
                    })
                    continue
            if _same_counterexample(goal, root, bool(decision.get("countermodel", {}).get("heap")), timeout_ms):
                disproved.add(kind)
            else:
                from .auto_parent_evidence import refute_parent_by_footprint
                witness = refute_parent_by_footprint(case, function, goal, root, kind, timeout_ms)
                if witness is not None:
                    info.setdefault("parent_counterexamples", []).append({"vc_index": i, **witness})
                    disproved.add(kind)
        if "safety" in disproved:
            status, reason = "CRASH", "invalid_safety_vc"
            phases["safety"] = "FAIL"
        elif disproved & {"return", "entailment", "which_implies"} and phases.get("safety") == "PASS":
            status, reason = "FAIL", "auto_spatial_invalid_parent"
            if "return" in disproved:
                phases["postcondition"] = "FAIL"
            if disproved & {"entailment", "which_implies"}:
                phases["annotations"] = "FAIL"
        elif (original_status == "UNKNOWN" and all(s == "VALID" for s in states)
              and (not execution or (
                  phases["execution"] == phases["safety"] == phases["postcondition"] == "PASS"
                  and (phases["annotations"] == "PASS" or
                       (case["mode"] == "entry-exit" and phases["annotations"] == "NOT_RUN"))))):
            status, reason = "PASS", "auto_original_obligations_valid"
    if status != original_status:
        case.update(status=status, overall=status, reason=reason, satisfied=status == "PASS",
                    test_result="FAIL" if status == "CRASH" else status,
                    evidence={"decision_backend":"auto-spatial-smt", "certificate":"NOT_CHECKED"})
    info["status"] = status


def run_auto(native_report: dict, output: Path, *, timeout_ms: int = 2000, only_case_ids=None) -> dict:
    """Run automatic decisions on a fresh copy. Never dispatch proof tasks."""
    from .itp_schedule import route_case_ids
    if (native_report.get("schema") != "qcp-spectest-report/v1" or
            native_report.get("vc_policy", {}).get("spatial_smt", {}).get("enabled") or
            "proof_completion" in native_report or
            any("spatial_smt" in case or "auto_route" in case for case in native_report["results"])):
        raise JobError("Auto requires an unrefined native report")
    if type(timeout_ms) is not int or not 1 <= timeout_ms <= 60000:
        raise JobError("invalid Auto solver timeout")
    output = Path(output).resolve()
    if output.exists() and any(output.iterdir()):
        raise JobError("Auto output must be fresh")
    output.mkdir(parents=True, exist_ok=True)
    selected = set(route_case_ids(native_report))
    if only_case_ids is not None:
        if set(only_case_ids) - selected:
            raise JobError("ineligible Auto case")
        selected = set(only_case_ids)
    started = time.monotonic()
    report = deepcopy(native_report)
    report["schema"] = "qcp-spectest-auto-route/v1"
    report["report"] = str(output / "report.json")
    report["itp_vcs"] = []
    for i, case in enumerate(report["results"]):
        key = _safe_case_id(case["id"], i)
        info = {"status": "NOT_RUN", "native_status":case["status"], "results":[]}
        case["auto_route"] = info
        if key not in selected:
            continue
        tick = time.monotonic()
        info["status"] = case["status"]
        try:
            _auto_case(case, report["function"], output / key, timeout_ms)
        except (OSError, KeyError, ValueError, TypeError, AttributeError, ImportError, RecursionError) as error:
            # Preserve raw verdict and phases on malformed inputs, including
            # exceptions after entry processing. Keep the diagnostic separate.
            case = report["results"][i] = deepcopy(native_report["results"][i])
            case["auto_route"] = info
            info.update(status=case["status"], error=str(error))
        info["wall_seconds"] = time.monotonic() - tick
    counts = Counter(c["status"] for c in report["results"])
    report["summary"] = {"total":len(report["results"]), **{s:counts[s] for s in CASE_STATUSES},
                         "attempted":len(selected), "duration_seconds":time.monotonic()-started}
    (output / "report.json").write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    return report
