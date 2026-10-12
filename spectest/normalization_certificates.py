"""Freeze definition-driven predicate rules and check their logical equations.

The strategy encoding remains part of the translator's trusted implementation.
Acceptance certifies the equations in the selected library interpretation; it
does not certify a program execution or equivalence of different heap models.
"""

import hashlib
import json
from pathlib import Path
import re

from .certificates import (
    QUALIFIED,
    check_certificate,
    check_dependency_namespace,
    digest,
    prepare_certificate,
)
from .core import JobError, _coq_load_path_args, _coq_required_modules
from .layout import target_layout_digest
from .rocq_predicates import (
    emit_equations,
    emit_model_refinements,
    emit_pure_projection_equations,
    emit_pure_projection_rules,
    emit_rules,
    parse_predicate,
    referenced_symbols,
    semantic_probes,
)


def _proof_interface(source):
    """Split only the translator's generated lemma format, not arbitrary Rocq."""
    start = source.find("\nLemma ")
    if start < 0:
        raise JobError("normalization must contain at least one equation")
    header, body = source[:start], source[start + 1 :]
    pattern = re.compile(
        r"Lemma ([A-Za-z_][A-Za-z0-9_]*) : (.*?)\.\n(Proof\..*?Qed\.)",
        re.S,
    )
    lemmas = pattern.findall(body)
    if not lemmas or pattern.sub("", body).strip():
        raise JobError("unsupported generated normalization proof format")
    names = [name for name, _, _ in lemmas]
    if len(set(names)) != len(names):
        raise JobError("duplicate generated normalization lemma")
    goal = header + "\n"
    candidate = header + "\nRequire Import Goal.\nModule Proofs.\n"
    interface = "Module Type VC_Correct.\n"
    for name, statement, proof in lemmas:
        goal += f"Definition {name}_goal : Prop := {statement}.\n"
        interface += f"Axiom proof_of_{name} : {name}_goal.\n"
        candidate += (
            f"Lemma proof_of_{name} : Goal.{name}_goal.\n"
            + proof.replace("Proof.", f"Proof. unfold Goal.{name}_goal.", 1)
            + "\n"
        )
    return goal + interface + "End VC_Correct.\n", candidate + "End Proofs.\n"


def prepare_predicate_normalization(
    definition,
    module,
    predicate,
    qcip_root,
    output,
    *,
    infer_models=False,
    dependencies=(),
    runtime_definition=False,
    first_rule_id=10000,
    execution_scope=None,
    notation_imports=(),
    target_layout=None,
    pure_facts_only=False,
):
    """Produce a pinned request; generated proofs have not yet been accepted."""
    definition, output = Path(definition).resolve(), Path(output).resolve()
    if pure_facts_only and infer_models:
        raise JobError("pure-fact projection cannot propose constructor witnesses")
    if output.exists():
        raise JobError("normalization output must not exist")
    if re.fullmatch(QUALIFIED, module) is None:
        raise JobError("invalid normalization module")
    if type(first_rule_id) is not int or first_rule_id < 0:
        raise JobError("first rule ID must be a nonnegative integer")
    if execution_scope is not None and (
        not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", execution_scope)
        or execution_scope in {"core", "post", "Pcancel", "Tagcancel", "local"}
    ):
        raise JobError("execution normalization requires a dedicated strategy scope")
    runtime = Path(qcip_root).resolve() / "SeparationLogic"
    if runtime_definition:
        # Import the actual pinned runtime module. Copying its source into a
        # differently named task module changes inductive type identities.
        candidates = []
        args = _coq_load_path_args(runtime, output)
        for index, arg in enumerate(args):
            if arg not in {"-R", "-Q"}:
                continue
            prefix = args[index + 2]
            if prefix and module.startswith(prefix + "."):
                suffix = module[len(prefix) + 1 :]
                physical = Path(args[index + 1]) / Path(*suffix.split("."))
                candidates.append(physical.with_suffix(".v").resolve())
        if len(candidates) != 1 or definition != candidates[0]:
            raise JobError("definition does not match the runtime module load path")
    else:
        check_dependency_namespace(module, runtime)
    # Parse and validate all input before creating a bundle.
    source = definition.read_text()
    context_modules = tuple(_coq_required_modules(source))
    clauses = parse_predicate(source, predicate, target_layout=target_layout)
    memory_rules = (
        target_layout.get("memory_rules", "naive_C_Rules")
        if target_layout is not None
        else "naive_C_Rules"
    )
    if not isinstance(memory_rules, str) or not re.fullmatch(QUALIFIED, memory_rules):
        raise JobError("invalid normalization memory rules module")
    notation_imports = tuple(notation_imports)
    equations = (emit_pure_projection_equations if pure_facts_only else emit_equations)(
        clauses,
        module,
        predicate,
        notation_imports=notation_imports,
        context_modules=context_modules,
        memory_rules=memory_rules,
    )
    if infer_models:
        equations += emit_model_refinements(clauses, module=module)
    goal, candidate = _proof_interface(equations)
    rule_options = dict(
        first_id=first_rule_id,
        scope=execution_scope if execution_scope is not None else "core",
    )
    rules = (
        emit_pure_projection_rules(clauses, **rule_options)
        if pure_facts_only
        else emit_rules(clauses, infer_models=infer_models, **rule_options)
    )
    rule_ids = [int(value) for value in re.findall(r"(?m)^id : (\d+)$", rules)]
    if any(rule_id > 2147483647 for rule_id in rule_ids):
        raise JobError("rule IDs exceed the executor's signed integer range")
    library_inputs = (
        [*dependencies] if runtime_definition else [(module, definition), *dependencies]
    )
    if len({name for name, _ in library_inputs}) != len(library_inputs):
        raise JobError("duplicate normalization dependency module")
    for name, path in library_inputs:
        if re.fullmatch(QUALIFIED, name) is None:
            raise JobError("invalid normalization dependency module")
        check_dependency_namespace(name, runtime)
        if not Path(path).is_file():
            raise JobError("missing normalization dependency: " + str(path))
    output.mkdir(parents=True)
    proposal = output / "proposal"
    proposal.mkdir()
    (proposal / "Goal.v").write_text(goal)
    original = {
        "schema": "qcp-spectest-vc-manifest/v1",
        "files": {"goal": str(proposal / "Goal.v")},
        "immutable_sha256": {"goal": digest(proposal / "Goal.v")},
        "qcip_root": str(Path(qcip_root).resolve()),
        "target_layout": target_layout
        if any(clause.uses_layout for _, _, clause in clauses)
        else None,
        "coq_dependencies": [
            {
                "module": name,
                "staged": str(Path(path).resolve()),
                "sha256": digest(Path(path)),
            }
            for name, path in library_inputs
        ],
    }
    # Explicit extra dependencies precede their importing definition.
    if not runtime_definition:
        original["coq_dependencies"] = (
            original["coq_dependencies"][1:] + original["coq_dependencies"][:1]
        )
    original_path = proposal / "manifest.json"
    original_path.write_text(json.dumps(original, indent=2) + "\n")
    prepared = prepare_certificate(original_path, output / "certificate")
    bundle_path = Path(prepared["manifest"])
    bundle = json.loads(bundle_path.read_text())
    (bundle_path.parent / "Candidate.v").write_text(candidate)
    rule_path = bundle_path.parent / "Normalization.strategies"
    rule_path.write_text(rules)
    bundle["immutable_sha256"][rule_path.name] = digest(rule_path)
    if any(clause.uses_layout for _, _, clause in clauses):
        layout_path = bundle_path.parent / "TargetLayout.json"
        layout_path.write_text(json.dumps(target_layout, indent=2) + "\n")
        bundle["immutable_sha256"][layout_path.name] = digest(layout_path)
    bundle["scope"] = "predicate-normalization-equations"
    bundle["normalization"] = {
        "module": module,
        "predicate": clauses[0][2].predicate,
        "source_predicate": predicate,
        "coq_predicate": clauses[0][2].coq_predicate or predicate,
        "infer_models": infer_models,
        "normalization_kind": "pure-fact-projection"
        if pure_facts_only
        else "full-unfolding",
        "definition_origin": "pinned-runtime"
        if runtime_definition
        else "task-dependency",
        "first_rule_id": first_rule_id,
        "rule_ids": rule_ids,
        "execution_scope": execution_scope,
        "notation_imports": list(notation_imports),
        "context_modules": list(context_modules),
        "definition_sha256": digest(definition),
        "rules_sha256": digest(rule_path),
        "encoding_trust": "definition-driven Rocq-to-QCP translator",
        "symbol_bindings": {
            symbol: f"normalization_binding_{index}"
            for index, symbol in enumerate(referenced_symbols(clauses))
        },
        "symbol_references": {
            symbol: module + "." + (clauses[0][2].coq_predicate or predicate)
            if symbol == clauses[0][2].predicate
            else symbol.replace("::", ".")
            for symbol in referenced_symbols(clauses)
        },
        "memory_rules": memory_rules,
        "semantic_bindings": semantic_probes(clauses),
        "uses_field_addresses": not pure_facts_only
        and any(
            clause.uses_layout
            or any("field_addr(" in qcp for qcp, _, _ in clause.atoms)
            for _, _, clause in clauses
        ),
        "layout_sha256": target_layout_digest(target_layout)
        if any(clause.uses_layout for _, _, clause in clauses)
        else None,
    }
    bundle_path.write_text(json.dumps(bundle, indent=2) + "\n")
    prepared.update(manifest_sha256=digest(bundle_path), status="PREPARED_UNCHECKED")
    (output / "request.json").write_text(json.dumps(prepared, indent=2) + "\n")
    return prepared


def check_predicate_normalization(
    path, expected_digest, *, switch="qcp-8.20", timeout=300, kernel_cache=None
):
    """Controller checks equations, dependency identity and kernel replay."""
    path = Path(path).resolve()
    # A failed new check must never leave an earlier usable-rule verdict.
    (path.parent / "normalization-report.json").unlink(missing_ok=True)
    if digest(path) != expected_digest:
        raise JobError("normalization request differs from controller digest")
    bundle = json.loads(path.read_text())
    if bundle.get("scope") != "predicate-normalization-equations":
        raise JobError("expected a predicate normalization certificate")
    report = check_certificate(
        path, expected_digest, switch=switch, timeout=timeout, kernel_cache=kernel_cache
    )
    report["activation"] = "CHECKED" if report["status"] == "PASS" else "UNAVAILABLE"
    report["rules"] = (
        str(path.parent / "Normalization.strategies")
        if report["status"] == "PASS"
        else None
    )
    (path.parent / "normalization-report.json").write_text(
        json.dumps(report, indent=2) + "\n"
    )
    return report


def seal_predicate_normalization(
    path, expected_digest, output, *, switch="qcp-8.20", timeout=300, kernel_cache=None
):
    """Recheck the proof and freeze the exact rule selection for a controller.

    This seals equation activation, not the association with a program's
    imports or layout. A calling controller must verify those separately.
    """
    path, output = Path(path).resolve(), Path(output).resolve()
    if output.exists():
        raise JobError("normalization activation output must not exist")
    report = check_predicate_normalization(
        path, expected_digest, switch=switch, timeout=timeout, kernel_cache=kernel_cache
    )
    if report["status"] != "PASS":
        return {
            "status": report["status"],
            "activation": "UNAVAILABLE",
            "proof": report,
        }
    if digest(path) != expected_digest:
        raise JobError("normalization manifest changed after checking")
    bundle = json.loads(path.read_text())
    scope = bundle["normalization"].get("execution_scope")
    if not scope or scope in {"core", "post", "Pcancel", "Tagcancel", "local"}:
        raise JobError("activation requires a dedicated execution scope")
    rules = (path.parent / "Normalization.strategies").read_bytes()
    rules_hash = hashlib.sha256(rules).hexdigest()
    if rules_hash != bundle["normalization"]["rules_sha256"]:
        raise JobError("normalization rules changed after checking")
    # Select only generated left clauses in the certified execution scope.
    # Mixed left/right model-choice clauses remain goal-side proof search.
    selected = []
    blocks = re.split(r"(?m)(?=^id : )", rules.decode())
    for block in blocks:
        rule_id = re.match(r"id : (\d+)\n", block)
        if (
            rule_id
            and re.search(rf"(?m)^priority : {re.escape(scope)}\(3\)$", block)
            and re.search(r"(?m)^left : ", block)
            and not re.search(r"(?m)^right : ", block)
        ):
            selected.append(int(rule_id[1]))
    if not selected or len(set(selected)) != len(selected):
        raise JobError("normalization must have unique certified left rule IDs")
    if not set(selected) <= set(bundle["normalization"]["rule_ids"]):
        raise JobError("normalization rule selection differs from its inventory")
    output.mkdir(parents=True)
    stem = "tespec_normalize_" + expected_digest
    target = output / (stem + ".strategies")
    target.write_bytes(rules)
    target.chmod(0o444)
    activation = {
        "schema": "tespec-normalization-activation/v1",
        "status": "PASS",
        "activation": "CHECKED",
        "scope": "predicate-normalization-equations",
        "manifest": str(path),
        "manifest_sha256": expected_digest,
        "rules": str(target),
        "rules_sha256": rules_hash,
        "module": bundle["normalization"]["module"],
        "definition_sha256": bundle["normalization"]["definition_sha256"],
        "runtime_sha256": bundle["runtime_sha256"],
        "dependencies": bundle["dependencies"],
        "executor_args": [
            "--spec-test-normalization-scope",
            scope,
            "--spec-test-normalization-file",
            stem,
            "--spec-test-normalization-rule-ids",
            ",".join(map(str, selected)),
        ],
        "proof": report,
        "program_association": "NOT_CHECKED",
    }
    (output / "activation.json").write_text(json.dumps(activation, indent=2) + "\n")
    return activation
