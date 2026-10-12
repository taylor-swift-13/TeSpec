"""Bind normalization equations to a program's actual Rocq import context."""

import json
from pathlib import Path
import re

from .certificates import QUALIFIED, digest, prepare_certificate, tree_digest
from .core import JobError
from .layout import generate_layout_source, target_layout_digest


def _pinned_json(path, expected):
    path = Path(path).resolve()
    if digest(path) != expected:
        raise JobError("controller-pinned manifest changed")
    return path, json.loads(path.read_text())


def _check_record(record):
    path = Path(record["path"]).resolve()
    if digest(path) != record["sha256"]:
        raise JobError("preflight context changed: " + str(path))
    return path


def prepare_normalization_association(
    preflight_path, preflight_digest, normalization_path, normalization_digest, output
):
    """Prepare identity goals in the unmodified program header.

    Equations and identity goals have separate proof scopes. Preparation is not
    authorization to execute a normalization rule.
    """
    preflight_path, program = _pinned_json(preflight_path, preflight_digest)
    normalization_path, normalization = _pinned_json(
        normalization_path, normalization_digest
    )
    if (
        program.get("schema") != "tespec-program-preflight/v1"
        or program.get("execution") != "NOT_RUN"
        or program.get("status") != "PARSED"
        or normalization.get("scope") != "predicate-normalization-equations"
    ):
        raise JobError("expected program preflight and normalization equations")
    for key in ("input", "binary", "generated_layout", "coq_header"):
        _check_record(program[key])
    for record in program["context_files"]:
        _check_record(record)
    runtime = Path(program["qcip_root"]).resolve() / "SeparationLogic"
    if (
        runtime != Path(normalization["runtime"]).resolve()
        or tree_digest(runtime) != normalization["runtime_sha256"]
    ):
        raise JobError("program and normalization runtime differ")
    modules = {}
    for dependency in program["coq_dependencies"]:
        module = dependency["module"]
        if module in modules:
            raise JobError("duplicate program dependency module")
        if digest(Path(dependency["staged"])) != dependency["sha256"]:
            raise JobError("program dependency changed: " + module)
        modules[module] = dependency
    for dependency in normalization["dependencies"]:
        path = (normalization_path.parent / dependency["file"]).resolve()
        if not path.is_relative_to(normalization_path.parent / "dependencies"):
            raise JobError("normalization dependency escapes its bundle")
        if digest(path) != dependency["sha256"]:
            raise JobError("normalization dependency changed")
        actual = modules.get(dependency["module"])
        if actual is None or actual["sha256"] != dependency["sha256"]:
            raise JobError("program definition mismatch: " + dependency["module"])
    for name, expected in normalization["immutable_sha256"].items():
        if (
            Path(name).name != name
            or digest(normalization_path.parent / name) != expected
        ):
            raise JobError("normalization immutable input changed")
    details = normalization["normalization"]
    semantic_bindings = details.get("semantic_bindings")
    if semantic_bindings is not None:
        layout = program.get("target_layout") or {}
        if details.get("memory_rules") != layout.get("memory_rules"):
            raise JobError("program and normalization memory rules differ")
        if not isinstance(semantic_bindings, dict) or not semantic_bindings:
            raise JobError("missing normalization semantic bindings")
    module, predicate = details["module"], details["predicate"]
    coq_predicate = details.get("coq_predicate", predicate.replace("::", "."))
    qcp_qualified = r"[A-Za-z_][A-Za-z0-9_']*(?:::[A-Za-z_][A-Za-z0-9_']*)*"
    if (
        not re.fullmatch(QUALIFIED, module)
        or not re.fullmatch(qcp_qualified, predicate)
        or not isinstance(coq_predicate, str)
        or not re.fullmatch(QUALIFIED, coq_predicate)
    ):
        raise JobError("invalid normalization predicate identity")
    if details["definition_origin"] == "task-dependency":
        if modules.get(module, {}).get("sha256") != details["definition_sha256"]:
            raise JobError("program does not import the certified definition")
    elif details["definition_origin"] != "pinned-runtime":
        raise JobError("unsupported definition origin")
    bindings = details.get("symbol_bindings")
    complete_bindings = bindings is not None
    equation_module = "TeSpecNormalizationEquations_" + normalization_digest
    if complete_bindings:
        if not isinstance(bindings, dict) or predicate not in bindings or not bindings:
            raise JobError("missing normalization symbol bindings")
        if len(set(bindings.values())) != len(bindings):
            raise JobError("duplicate normalization binding alias")
        references = details.get(
            "symbol_references", {symbol: symbol for symbol in bindings}
        )
        if (
            not isinstance(references, dict)
            or set(references) != set(bindings)
            or any(
                not isinstance(value, str) or not re.fullmatch(QUALIFIED, value)
                for value in references.values()
            )
        ):
            raise JobError("invalid normalization symbol references")
        equation_path = normalization_path.parent / "Goal.v"
        if "Goal.v" not in normalization["immutable_sha256"]:
            raise JobError("normalization binding context is not immutable")
        equations = equation_path.read_text()
        declared = re.findall(
            rf"Definition (normalization_binding_[0-9]+) := @({QUALIFIED})\.",
            equations,
        )
        if sorted(declared) != sorted(
            (alias, references[symbol]) for symbol, alias in bindings.items()
        ):
            raise JobError(
                "normalization binding inventory differs from frozen context"
            )
        for symbol, alias in bindings.items():
            if (
                not (
                    re.fullmatch(QUALIFIED, symbol)
                    or re.fullmatch(qcp_qualified, symbol)
                )
                or not re.fullmatch(r"normalization_binding_[0-9]+", alias)
                or equations.count(f"Definition {alias} := @{references[symbol]}.") != 1
            ):
                raise JobError("invalid frozen normalization symbol binding")
        if semantic_bindings is not None:
            declared_semantics = dict(
                re.findall(
                    r"(?m)^Definition normalization_semantics_([A-Za-z_][A-Za-z0-9_]*) := (.+)\.$",
                    equations,
                )
            )
            if declared_semantics != semantic_bindings:
                raise JobError("normalization semantics differ from frozen context")
            for key, expression in semantic_bindings.items():
                if (
                    not re.fullmatch(r"[A-Za-z_][A-Za-z0-9_]*", key)
                    or not isinstance(expression, str)
                    or "\n" in expression
                    or "\r" in expression
                ):
                    raise JobError("invalid normalization semantic binding")
        if equation_module in modules:
            raise JobError("program shadows normalization equation module")
    # Field unfolding must use the actual computational layout, even when an
    # abstract-layout equation is valid in its own proof context.
    rules = normalization_path.parent / "Normalization.strategies"
    uses_fields = details.get("uses_field_addresses", False) or (
        rules.is_file() and "field_addr(" in rules.read_text()
    )
    if details.get("layout_sha256") and details[
        "layout_sha256"
    ] != target_layout_digest(program["target_layout"]):
        raise JobError("normalization offsets differ from actual target layout")
    if "TargetLayout.json" in normalization[
        "immutable_sha256"
    ] and target_layout_digest(
        json.loads((normalization_path.parent / "TargetLayout.json").read_text())
    ) != details.get("layout_sha256"):
        raise JobError("normalization frozen layout differs from offset encoding")
    if uses_fields and (
        "GeneratedLayout" not in modules
        or "LayoutAddress" not in modules
        or "GeneratedLayout.AddressNotations" not in details.get("notation_imports", [])
    ):
        raise JobError("field normalization requires actual computational layout")
    # These reserved modules implement the explicit computational layout API.
    # Matching them is a strict initial gate; abstract layouts remain separate.
    if "GeneratedLayout" in modules:
        expected = generate_layout_source(program["target_layout"])
        if Path(modules["GeneratedLayout"]["staged"]).read_text() != expected:
            raise JobError("program computational layout differs from actual target")
        canonical = (
            Path(__file__).resolve().parents[1] / "runtime/tespec/LayoutAddress.v"
        )
        if modules.get("LayoutAddress", {}).get("sha256") != digest(canonical):
            raise JobError("program layout address implementation differs")
    output = Path(output).resolve()
    if output.exists():
        raise JobError("association output must be fresh")
    output.mkdir(parents=True)
    proposal = output / "proposal"
    proposal.mkdir()
    header = Path(program["coq_header"]["path"]).read_text()
    # Capture program names before importing the equation context. This checks
    # constructors and RHS callees as well as the primary predicate.
    proof_goals = []
    if complete_bindings:
        goal = header + "\n"
        for index, symbol in enumerate(bindings):
            goal += f"Definition tespec_program_binding_{index} := @{symbol.replace('::', '.')}.\n"
        for key, expression in (semantic_bindings or {}).items():
            goal += f"Definition tespec_program_semantics_{key} := {expression}.\n"
        goal += f"Require Import {equation_module}.\n"
        for index, alias in enumerate(bindings.values()):
            name = f"binding_{index}_goal"
            goal += (
                f"Definition {name} : Prop := @tespec_program_binding_{index} = "
                f"@{equation_module}.{alias}.\n"
            )
            proof_goals.append((f"proof_of_binding_{index}", name))
        goal += (
            "Definition predicate_identity_goal : Prop := "
            f"@{equation_module}.{bindings[predicate]} = @{module}.{coq_predicate}.\n"
        )
        proof_goals.append(("proof_of_predicate_identity", "predicate_identity_goal"))
        for key in semantic_bindings or {}:
            name = f"semantics_{key}_goal"
            goal += (
                f"Definition {name} : Prop := @tespec_program_semantics_{key} = "
                f"@{equation_module}.normalization_semantics_{key}.\n"
            )
            proof_goals.append((f"proof_of_semantics_{key}", name))
    else:
        goal = header + (
            f"\nDefinition predicate_identity_goal : Prop := @{predicate.replace('::', '.')} = @{module}.{coq_predicate}.\n"
        )
        proof_goals.append(("proof_of_predicate_identity", "predicate_identity_goal"))
    goal += "Module Type VC_Correct.\n"
    for proof, name in proof_goals:
        goal += f"Axiom {proof} : {name}.\n"
    goal += "End VC_Correct.\n"
    goal_path = proposal / "Goal.v"
    goal_path.write_text(goal)
    dependencies = list(modules.values())
    for record in program["context_files"]:
        path = Path(record["path"])
        if (
            path.parent == Path(program["coq_header"]["path"]).parent
            and path.name != Path(program["coq_header"]["path"]).name
        ):
            if path.stem in modules:
                raise JobError("generated context shadows a task module")
            dependencies.append(
                {"module": path.stem, "staged": str(path), "sha256": record["sha256"]}
            )
    if complete_bindings:
        if any(record["module"] == equation_module for record in dependencies):
            raise JobError("generated context shadows normalization equation module")
        dependencies.append(
            {
                "module": equation_module,
                "staged": str(equation_path),
                "sha256": digest(equation_path),
            }
        )
    original = {
        "schema": "qcp-spectest-vc-manifest/v1",
        "files": {"goal": str(goal_path)},
        "immutable_sha256": {"goal": digest(goal_path)},
        "qcip_root": program["qcip_root"],
        "coq_dependencies": dependencies,
        "target_layout": program["target_layout"],
    }
    original_path = proposal / "manifest.json"
    original_path.write_text(json.dumps(original, indent=2) + "\n")
    request = prepare_certificate(original_path, output / "certificate")
    manifest_path = Path(request["manifest"])
    bundle = json.loads(manifest_path.read_text())
    bundle["scope"] = "program-normalization-association"
    bundle["association"] = {
        "preflight_manifest": str(preflight_path),
        "preflight_sha256": preflight_digest,
        "normalization_manifest": str(normalization_path),
        "normalization_sha256": normalization_digest,
        "module": module,
        "predicate": predicate,
        "binding_scope": "all-referenced-symbols"
        if complete_bindings
        else "predicate-only",
        "symbols": list(bindings) if complete_bindings else [predicate],
        "definition_binding_scope": "qualified-selected-predicate",
        "semantic_binding_scope": "formula-notation-interpretations"
        if complete_bindings and semantic_bindings
        else "NOT_CHECKED",
        "memory_rules": details.get("memory_rules"),
        "authorization": "NOT_GRANTED",
    }
    manifest_path.write_text(json.dumps(bundle, indent=2) + "\n")
    candidate = "Require Import Goal.\nModule Proofs.\n"
    for proof, name in proof_goals:
        candidate += (
            f"Lemma {proof} : Goal.{name}.\n"
            f"Proof. unfold Goal.{name}. reflexivity. Qed.\n"
        )
    (manifest_path.parent / "Candidate.v").write_text(candidate + "End Proofs.\n")
    request["manifest_sha256"] = digest(manifest_path)
    request["status"] = "PREPARED_UNCHECKED"
    (output / "request.json").write_text(json.dumps(request, indent=2) + "\n")
    return request
