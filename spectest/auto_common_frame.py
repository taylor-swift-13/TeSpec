"""Lift a proved residual heap entailment through an unchanged separator frame."""
import re
from collections import Counter

from tools.finite_spatial_smt import qcp_import as qcp
from tools.finite_spatial_smt.finite_spatial_smt import Unsupported

from .auto_definitions import definitions_for, frozen_bytes
from .certificates import strip_comments
from .core import JobError


def _tokens(term):
    return tuple(re.findall(r'"(?:[^"]|"")*"|[A-Za-z_][\w\x27]*|[0-9]+|[^\s]', term))


def _coq_atom(name, args, environments):
    """Render only closed constants or native locals with a stable lexical ID."""
    terms = []
    for arg in args:
        if re.fullmatch(r"0|[1-9][0-9]*", arg):
            terms.append(arg)
            continue
        match = re.fullmatch(r"([A-Za-z_]\w*)_([0-9]+)_addr", arg)
        if not match or not all(env.get(match[1], (None,))[0] == arg for env in environments):
            return None
        terms.append(f'(&("{match[1]}_spec_{match[2]}"))')
    return _tokens("(" + name + " " + " ".join(terms) + ")")


def _separated_atoms(side):
    lines = [line.strip() for line in side.splitlines() if line.strip()]
    if lines and lines[0] == "(":
        lines = lines[1:]
    if lines and lines[-1] == ")":
        lines.pop()
    if lines and lines[0].startswith(("forall ", "EX ")):
        if not lines[0].endswith(","):
            return Counter()
        lines = lines[1:]
    atoms = Counter()
    spatial = False
    for i, line in enumerate(lines):
        operator = line[:2] if i else ""
        if i and operator not in ("**", "&&"):
            return Counter()
        term = line[len(operator):].strip()
        if term.startswith("“") and term.endswith("”") and not spatial and operator != "**":
            continue
        if spatial != (operator == "**"):
            return Counter()
        spatial = True
        # One complete top-level atom per printer line. A second expression,
        # open parenthesis or a negation wrapping another line is unsupported.
        if not term.startswith("(") or not term.endswith(")"):
            return Counter()
        depth = 0
        for j, ch in enumerate(term):
            depth += (ch == "(") - (ch == ")")
            if depth <= 0 and j != len(term) - 1:
                return Counter()
        if depth:
            return Counter()
        atoms[_tokens(term)] += 1
    return atoms


def _frame_in_root(source, root, name, required):
    if not re.fullmatch(r"[A-Za-z_]\w*", root):
        return False
    declarations = list(re.finditer(r"(?m)^Definition\s+" + root + r"\s*:=\s*", source))
    if len(declarations) != 1:
        return False
    body = re.split(r"\.(?=\s|$)", source[declarations[0].end():], maxsplit=1)[0]
    for arm in re.split(r"(?m)^\)\s*\\/\s*$", body):
        if arm.count("|--") != 1:
            continue
        # Only generated, explicitly typed binders. Neither side may introduce
        # a local interpretation of the predicate identifier.
        if (re.search(r"\b(?:fun|let|match|fix|exists)\b|=>|:=|(?<!\|)->", arm)
                or re.search(r"\b(?:forall|EX)\s+(?!\()", arm)
                or re.search(r"\([^():]*\b" + name + r"\b[^():]*:", arm)):
            continue
        sides = [_separated_atoms(side) for side in arm.split("|--")]
        if all(required <= side for side in sides):
            return True
    return False


def _without_frame(part, terms, frame):
    remaining = frame.copy()
    kept = []
    for atom in terms:
        if remaining[atom]:
            remaining[atom] -= 1
        else:
            kept.append(atom)
    return f"{part['ex']}PROP[{part['pure']}]\nLOCAL[{part['local']}]\nSEP[{';'.join(kept)}]\n"


def prove_with_common_frame(record, case, name, solve):
    """Prove the full remainder, then use monotonicity of separating conjunction."""
    if record.get("check_mode") != "exact" or not re.fullmatch(r"[A-Za-z_]\w*", name):
        return None
    vc = record["vc"]
    try:
        pre, post = (qcp.assertion_parts(vc[k]) for k in ("path", "goal"))
        if len(pre) != 1 or len(post) != 1:
            return None
        parts = (pre[0], post[0])
        qcp.checked_local_symbols(pre, post, vc["path"] + "\n" + vc["goal"], record.get("local_semantics"))
        environments = [qcp.local_bindings(part) for part in parts]
        bound = set().union(*(qcp.existential_names(part) for part in parts))
        terms = [qcp.split_top(part["spatial"], ";") for part in parts]
        defs, layout, _ = definitions_for(case)
        predicate = defs.get(name)
        if (not predicate or predicate.result != "Assertion" or layout != record["layout"]
                or name in bound or not all(sort == "Z" for _, sort in predicate.args)):
            return None
        frame, required = Counter(), Counter()
        for atom, count in (Counter(terms[0]) & Counter(terms[1])).items():
            symbol, args = qcp.call(atom)
            if symbol != name or len(args) != len(predicate.args) or bound.intersection(args):
                continue
            coq_atom = _coq_atom(name, args, environments)
            if coq_atom:
                frame[atom] = count
                required[coq_atom] += count
        roots = vc.get("proof_roots")
        if not frame or not isinstance(roots, list) or not roots:
            return None
        manifest = case["vc"]
        sha = manifest["immutable_sha256"]["goal"]
        source = strip_comments(frozen_bytes(manifest["files"]["goal"], sha).decode())
        if not all(_frame_in_root(source, root, name, required) for root in roots):
            return None
        path, goal = (_without_frame(part, atoms, frame) for part, atoms in zip(parts, terms))
        result = solve(record | {"vc": vc | {"path": path, "goal": goal}})
    except (Unsupported, JobError, OSError, ValueError, KeyError, TypeError, RecursionError):
        return None
    if result.get("status") != "VALID":
        return None
    result = dict(result)
    result["common_frame"] = {
        "rule": "sepcon_monotonicity", "atoms": list(frame.elements()),
        "proof_roots": roots, "goal_sha256": sha,
        "subquery_antecedent_satisfiability": result.pop("antecedent_satisfiability", None),
    }
    result.pop("vacuous", None)
    result["reason"] = "common_frame_and_valid_remainder"
    return result
