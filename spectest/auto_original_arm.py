"""Build and kernel-check a proof term for a pure arm of an original spatial VC."""

import hashlib
from pathlib import Path
import re
import subprocess
from tempfile import TemporaryDirectory

from tools.finite_spatial_smt.finite_spatial_smt import Unsupported

from .auto_definitions import (
    ID,
    definitions_for,
    frozen_bytes,
    require,
    split_operator,
    unparen,
)
from .auto_guard_recheck import alignment_proof_source
from .certificates import strip_comments
from .core import _consume_balanced, _coq_load_path_args, _coq_required_modules
from .layout_job import auto_compiler


def _pure_term(body):
    """Construct a candidate for forall ..., TT && emp |-- pure facts && emp."""
    if not body.startswith("forall "):
        return None
    header, formula = split_operator(body[7:], ",")
    sides = split_operator(formula, "|--")
    if not sides or unparen(sides[0]).split() != ["TT", "&&", "emp"]:
        return None
    names, hypotheses = [], {}
    while header:
        binder, end = _consume_balanced(header, 0, "(", ")")
        header = header[end:].strip()
        symbol, ty = (s.strip() for s in binder.split(":", 1))
        require(
            re.fullmatch(ID, symbol)
            and symbol not in names
            and symbol not in {"_", "tespec_m", "tespec_h"},
            "unbound_or_shadowed_binder",
        )
        names.append(symbol)
        hypotheses[unparen(ty)] = symbol
    parts = [s.strip() for s in unparen(sides[1]).split("&&")]
    if not (1 < len(parts) <= 128 and parts[-1] == "emp"):
        return None
    terms = []
    for atom in parts[:-1]:
        if not (atom.startswith("“") and atom.endswith("”")):
            return None
        prop = unparen(atom[1:-1])
        if prop in hypotheses:
            term = hypotheses[prop]
        elif prop == "True":
            term = "Coq.Init.Logic.I"
        elif ne := re.fullmatch(r"(-?\d{1,80})\s*<>\s*(-?\d{1,80})", prop):
            term = (
                f"(Coq.Init.Logic.proj1 (Z.eqb_neq ({ne[1]}) ({ne[2]})) "
                "Coq.Init.Logic.eq_refl)"
            )
        else:
            # Kernel conversion must verify the entire equality, including any
            # imported functions. No text-based evaluation or fresh axioms.
            term = "Coq.Init.Logic.eq_refl"
        terms.append(term)
    terms.append("(Coq.Init.Logic.proj2 tespec_h)")
    conjunction = terms[0]
    for term in terms[1:]:
        conjunction = f"(Coq.Init.Logic.conj {conjunction} {term})"
    return "(fun " + " ".join(names) + " tespec_m tespec_h => " + conjunction + ")"


def _arm_term(body, depth=0):
    require(len(body) <= 65536 and depth <= 8, "arm_budget")
    text = unparen(body)
    branches = split_operator(text, r"\/")
    if branches:
        for direction, branch in zip(("or_introl", "or_intror"), branches):
            term = _arm_term(branch, depth + 1)
            if term:
                return f"(Coq.Init.Logic.{direction} {term})"
        return None
    return _pure_term(text)


def _check_terms(manifest, receipt, raw, terms, timeout_ms):
    """Check in the entire frozen goal module, with its original logical name."""
    source_name = Path(manifest["files"]["goal"]).name
    require(re.fullmatch(ID + r"\.v", source_name), "invalid_goal_module")
    pending = {}
    for dep in [*manifest["coq_dependencies"], *manifest["generated_coq_dependencies"]]:
        name = dep["module"]
        require(
            re.fullmatch(ID, name)
            and name not in pending
            and name + ".v" != source_name,
            "ambiguous_local_module",
        )
        data = frozen_bytes(dep["staged"], dep["sha256"])
        if name == "input_def" and receipt:
            version = receipt["generated"][name]
            require(
                receipt["goal_sha256"] == manifest["immutable_sha256"]["goal"]
                and version["original"] == dep["sha256"],
                "wrong_alignment_context",
            )
            if version["compiled_source"] != version["original"]:
                data = alignment_proof_source(
                    data.decode(), manifest["target_layout"]
                ).encode()
                require(
                    hashlib.sha256(data).hexdigest() == version["compiled_source"],
                    "wrong_alignment_proof",
                )
        pending[name] = data

    def check_runtime():
        for dep in manifest["runtime_dependencies"]:
            frozen_bytes(dep["source"], dep["sha256"])
            frozen_bytes(dep["compiled"], dep["compiled_sha256"])

    check_runtime()
    with TemporaryDirectory(prefix="tespec-auto-original-") as tmp:
        wd = Path(tmp)
        args = [
            *auto_compiler(),
            "-q",
            *_coq_load_path_args(Path(manifest["qcip_root"]) / "SeparationLogic", wd),
        ]

        def compile_source(name, data, seconds):
            path = wd / name
            path.write_bytes(data)
            subprocess.run(
                [*args, str(path)],
                cwd=wd,
                capture_output=True,
                timeout=seconds,
                check=True,
            )

        while pending:
            ready = [
                name
                for name, data in pending.items()
                if not set(_coq_required_modules(data.decode())) & pending.keys()
            ]
            require(ready, "cyclic_original_dependencies")
            for name in ready:
                # Compile the source closure, as in the checked layout route.
                compile_source(name + ".v", pending.pop(name), 60)
        suffix = "".join(
            f"\nDefinition TeSpecAutoArm_{name} : {name} := {term}.\n"
            for name, term in terms.items()
        )
        compile_source(source_name, raw + suffix.encode(), timeout_ms / 1000)
    check_runtime()


def prove_original_arm(case, record, timeout_ms):
    """Return positive evidence only when the kernel accepts every bound root."""
    try:
        roots = record["vc"]["proof_roots"]
        require(
            record.get("check_mode") == "exact"
            and isinstance(roots, list)
            and 0 < len(roots) <= 8
            and len(set(roots)) == len(roots),
            "unmapped_original_arm",
        )
        manifest = case["vc"]
        sha = manifest["immutable_sha256"]["goal"]
        raw = frozen_bytes(manifest["files"]["goal"], sha)
        source = strip_comments(raw.decode())
        terms = {}
        for root in roots:
            require(re.fullmatch(ID, root), "invalid_original_root")
            (hit,) = re.finditer(
                r"^Definition " + re.escape(root) + r"\s*:=\s*(.*?)\.(?=\s|$)",
                source,
                re.M | re.S,
            )
            term = _arm_term(hit[1])
            if not term:
                return None
            terms[root] = term
        _, layout, _ = definitions_for(case)
        require(layout == record["layout"], "wrong_layout")
        _check_terms(manifest, case.get("auto_guard_recheck"), raw, terms, timeout_ms)
        return {
            "status": "VALID",
            "reason": "original_pure_arm_kernel_checked",
            "supported": True,
            "certificate": "KERNEL_CHECKED",
            "proof_roots": roots,
            "goal_sha256": sha,
            "proof_terms": terms,
        }
    except (
        OSError,
        RecursionError,
        ValueError,
        KeyError,
        TypeError,
        Unsupported,
        subprocess.SubprocessError,
    ):
        return None
