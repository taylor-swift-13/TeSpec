"""Keep proved, witness-independent predicate facts visible during native unfolding."""

import hashlib
import re
import subprocess
from pathlib import Path

from .core import (
    JobError,
    _coq_dependency_code,
    _coq_load_path_args,
    _sha256,
    qcp_annotations,
)
from .errors import FieldLayoutMismatch
from .rocq_predicates import (
    emit_pure_projection_equations,
    emit_pure_projection_rules,
    parse_predicate,
    pure_projection_atoms,
    referenced_symbols,
    semantic_probes,
)

_ID = r"[A-Za-z_][A-Za-z0-9_]*"
_SCOPE = "tespec_checked_guards"


def declared_predicates(source):
    declared = set()
    for token in qcp_annotations(source):
        annotation = re.fullmatch(r"/\*@\s*Extern\s+Coq\b(.*?)\*/", token[0], re.S)
        if annotation:
            declared.update(
                re.findall(rf"\(\s*({_ID})\s*:[^()]*?\bAssertion\s*\)", annotation[1])
            )
    return declared


def candidates(source, modules, build, layout):
    """Select only unambiguous declarations in the explicitly rebound libraries."""
    declared = declared_predicates(source)
    found = {}
    for module in modules:
        text = (build / (module + ".v")).read_text()
        identifiers = set(
            re.findall(
                rf"\b(?:Definition|Fixpoint)\s+({_ID})\b", _coq_dependency_code(text)
            )
        )
        for name in sorted(identifiers & declared):
            found.setdefault(name, []).append((module, text))
    for name, owners in sorted(found.items()):
        if len(owners) != 1:
            continue
        module, text = owners[0]
        try:
            clauses = parse_predicate(text, name, target_layout=layout)
        except JobError:
            continue
        if clauses[0][2].predicate == name and any(
            pure_projection_atoms(c) for _, _, c in clauses
        ):
            yield module, name, clauses


def compile_unit(args, build, path):
    try:
        result = subprocess.run(
            [*args, str(path)], cwd=build, capture_output=True, text=True, timeout=60
        )
    except subprocess.TimeoutExpired:
        return "Coq check timed out"
    if result.returncode:
        return result.stderr[-650:] or f"Coq exited with status {result.returncode}"
    return None


def prepare_guards(proposals, program, build, output, compiler):
    """Check the projection equations and their symbol identities before emitting any rules."""
    header_path = Path(program["coq_header"]["path"])
    header = header_path.read_text()
    layout = program["target_layout"]
    runtime = Path(program["qcip_root"]) / "SeparationLogic"
    args = [*compiler, "-q", *_coq_load_path_args(runtime, build)]
    rules, proved, skipped = [], [], {}
    proofs = {}
    generated = {}
    # The frontend can also generate a module with program-local definitions.
    # Compile its exact source on the same load path as the association checks.
    local_module = header_path.with_name("input_def.v")
    if local_module.is_file():
        digest = _sha256(local_module)
        snapshot = {
            record["path"]: record["sha256"] for record in program["context_files"]
        }
        target = build / local_module.name
        if target.exists() or snapshot.get(str(local_module)) != digest:
            raise JobError("ambiguous or changed generated guard dependency")
        target.write_bytes(local_module.read_bytes())
        if _sha256(target) != digest:
            raise JobError("generated guard dependency changed during preparation")
        issue = compile_unit(args, build, target)
        if issue:
            return None, {
                "proved": [],
                "skipped": {name: issue for _, name, _ in proposals},
            }
        generated[local_module.stem] = digest
    first_id = 10000
    for module, name, clauses in proposals:
        equations = emit_pure_projection_equations(
            clauses, module, name, memory_rules=layout["memory_rules"]
        )
        key = hashlib.sha256(equations.encode()).hexdigest()[:24]
        unit = "TeSpecGuard_" + key
        # Require without Import keeps every unqualified name in the program's
        # original scope. Coq checks predicate, constructors, callees and notation.
        associations = [header, f"Require {unit}."]
        for i, sym in enumerate(referenced_symbols(clauses)):
            associations.append(
                f"Check (eq_refl : @{sym.replace('::', '.')} = @{unit}.normalization_binding_{i})."
            )
        for label, expr in semantic_probes(clauses).items():
            associations.append(
                f"Check (eq_refl : {expr} = {unit}.normalization_semantics_{label})."
            )
        sources = {unit: equations, unit + "_Bindings": "\n".join(associations) + "\n"}
        for basename, text in sources.items():
            path = build / (basename + ".v")
            if path.exists():
                raise JobError("generated guard module name collision: " + basename)
            path.write_text(text)
            issue = compile_unit(args, build, path)
            if issue:
                skipped[name] = issue
                break
        else:
            output.mkdir(exist_ok=True)
            for basename, text in sources.items():
                proof = output / (basename + ".v")
                proof.write_text(text)
                proofs[proof.name] = _sha256(proof)
            rules.append(
                emit_pure_projection_rules(clauses, first_id=first_id, scope=_SCOPE)
            )
            count = sum(len(pure_projection_atoms(c)) for _, _, c in clauses)
            first_id += count
            proved.append(
                {"predicate": module + "." + name, "guards": count, "proof": unit}
            )
    context = None
    if rules:
        content = "\n".join(rules).encode()
        digest = hashlib.sha256(content).hexdigest()
        path = output / ("tespec_guards_" + digest + ".strategies")
        path.write_bytes(content)
        context = {
            "path": str(path),
            "sha256": digest,
            "rule_ids": list(range(10000, first_id)),
            "proof_files": proofs,
            "header_sha256": program["coq_header"]["sha256"],
            "generated_modules": generated,
            "binary_sha256": program["binary"]["sha256"],
        }
    return context, {"proved": proved, "skipped": skipped}


def guard_activation(context, binary_sha256):
    if not isinstance(context, dict) or not isinstance(context.get("path"), str):
        raise FieldLayoutMismatch("invalid checked guard context")
    path = Path(context["path"])
    if (
        not path.is_absolute()
        or re.search(r'["\\\r\n]', str(path))
        or context.get("binary_sha256") != binary_sha256
    ):
        raise FieldLayoutMismatch("checked projection path or executor changed")
    try:
        content = path.read_bytes()
    except OSError as error:
        raise FieldLayoutMismatch("checked projection rules are unavailable") from error
    digest = hashlib.sha256(content).hexdigest()
    if (
        digest != context.get("sha256")
        or path.name != "tespec_guards_" + digest + ".strategies"
    ):
        raise FieldLayoutMismatch("checked projection rules changed")
    proofs = context.get("proof_files")
    if not isinstance(proofs, dict) or not proofs:
        raise FieldLayoutMismatch("missing checked guard proofs")
    for name, expected in proofs.items():
        if not re.fullmatch(r"TeSpecGuard_[a-f0-9]{24}(?:_Bindings)?\.v", name):
            raise FieldLayoutMismatch("invalid checked guard proof name")
        proof = path.parent / name
        if not proof.is_file() or _sha256(proof) != expected:
            raise FieldLayoutMismatch("checked guard proof changed")
    ids = re.findall(r"(?m)^id : (\d+)$", content.decode())
    if not ids or list(map(int, ids)) != context.get("rule_ids"):
        raise FieldLayoutMismatch("checked guard rule selection changed")
    return '\n/*@ include strategies "' + str(path) + '" */\n', [
        "--spec-test-normalization-scope=" + _SCOPE,
        "--spec-test-normalization-file=" + path.stem,
        "--spec-test-normalization-rule-ids=" + ",".join(ids),
    ]


def guard_header(goal):
    # A rejected entry can emit only the precondition definition. No executed
    # function banner is printed in that case.
    marker = re.search(
        r"(?m)^(?:\(\*----- Function [A-Za-z_]\w* -----\*\)$|"
        r"Definition [A-Za-z_]\w*_precondition_wit_\d+ :=$|Module Type VC_Correct\.$)",
        goal,
    )
    if not marker:
        raise FieldLayoutMismatch("cannot identify original goal header")
    return goal[:marker.start()]


def check_guard_header(context, goal):
    if hashlib.sha256(guard_header(goal).encode()).hexdigest() != context.get("header_sha256"):
        raise FieldLayoutMismatch("goal header differs from the checked guard bindings")
