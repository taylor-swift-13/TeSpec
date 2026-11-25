"""Finite elimination of two positive existential list witnesses in an append equality."""
import ast
import re
from pathlib import Path

from tools.finite_spatial_smt import qcp_import as qcp
from tools.finite_spatial_smt.finite_qcp_terms import normalize_builtin_type_arguments
from tools.finite_spatial_smt.finite_spatial_smt import CONSTANTS, Unsupported


def _args(node, function, arity):
    if (isinstance(node, ast.Call) and isinstance(node.func, ast.Name)
            and node.func.id == function and not node.keywords and len(node.args) == arity + 1
            and isinstance(node.args[0], ast.Name) and node.args[0].id == "Z_1"):
        return node.args[1:]
    return None


_INTEGER_LIMITS = frozenset({"INT_MAX", "INT_MIN", "UINT_MAX"})


def _numeral_list(node, constants):
    """Read literal elements only. Identifiers can denote locally shadowed integers."""
    if _args(node, "nil", 0) is not None:
        return ()
    cons = _args(node, "cons", 2)
    if cons is not None:
        value, rest = cons
        negative = isinstance(value, ast.UnaryOp) and isinstance(value.op, ast.USub)
        literal = value.operand if negative else value
        if isinstance(literal, ast.Constant) and type(literal.value) is int:
            number = literal.value
        elif isinstance(literal, ast.Name) and literal.id in constants:
            number = CONSTANTS[literal.id]
        else:
            raise Unsupported("nonliteral_list_element")
        if negative:
            number = -number
        return (str(number),) + _numeral_list(rest, constants)
    append = _args(node, "app", 2)
    if append is not None:
        return _numeral_list(append[0], constants) + _numeral_list(append[1], constants)
    raise Unsupported("nonliteral_list_expression")


def original_list_scope(case, vc):
    """Check that the generated root has not shadowed the recognized list primitives.

    definitions_for has already checked the initial goal header and module exports.
    Only generated Definitions may intervene before the current root.
    """
    from .auto_definitions import frozen_bytes
    from .certificates import strip_comments

    roots = vc.get("proof_roots")
    if not isinstance(roots, list) or not roots or not all(
            isinstance(root, str) and re.fullmatch(r"[A-Za-z_]\w*", root) for root in roots):
        return False
    manifest = case["vc"]
    source = strip_comments(frozen_bytes(manifest["files"]["goal"], manifest["immutable_sha256"]["goal"]).decode())
    start = re.search(r"(?m)^Definition\s", source)
    if not start:
        return False
    limits = _INTEGER_LIMITS.intersection(re.findall(r"\b[A-Za-z_]\w*\b", vc.get("path", "") + "\n" + vc.get("goal", "")))
    if limits:
        from .auto_definitions import QCP_INTEGER_PRELUDE
        # IntLib's notations are exported by SeparationLogic, then VCPrelude.
        # A matching basename or an unrelated project-level definition is insufficient.
        header = source[:start.start()]
        if not re.search(r"(?m)^From SimpleC\.Verification Require Import VCPrelude\.\s*$", header):
            return False
        base = Path(manifest["qcip_root"]) / "SeparationLogic" / "SeparationLogic"
        for file, digest in QCP_INTEGER_PRELUDE.items():
            frozen_bytes(base / file, digest)
        for section in ("path", "goal"):
            if vc.get(section) and any(limits.intersection(qcp.existential_names(part))
                                       for part in qcp.assertion_parts(vc[section])):
                return False
    symbols = r"(?:app|rev|nil|cons|Z|list|INT_MIN|INT_MAX|UINT_MAX)"
    remaining = set(roots)
    for command in re.split(r"\.(?=\s|$)", source[start.start():]):
        definition = re.match(r"\s*Definition\s+([\w']+)\s*:=\s*", command)
        if not definition or re.fullmatch(symbols, definition[1]):
            return False
        if definition[1] in remaining:
            body = command[definition.end():]
            # The native printer uses explicitly typed, parenthesized Coq binders.
            # Reject nonprinter binders and locally reinterpreted primitives.
            if (re.search(r"\b(?:fun|let|fix|match)\b|=>", body)
                    or re.search(r"\b(?:forall|EX)\s+(?!\()", body)
                    or re.search(r"\([^():]*\b" + symbols + r"\b[^():]*:", body)):
                return False
            remaining.remove(definition[1])
        if not remaining:
            return True
    return False


def _relation(prop, names, constants=frozenset()):
    """Recognize app(f(a), g(b)) = closed, with f,g each identity or list reverse."""
    from .auto_definitions import RESERVED, list_length_bound

    if "app" not in prop or "==" not in prop or len(prop) > 4096:
        return None
    if not re.fullmatch(r"[A-Za-z0-9_{}(),=\s-]+", prop):
        return None
    typed = normalize_builtin_type_arguments(prop)
    typed = re.sub(r"(?<![\w.])rev\s*\{\s*Z_1\s*\}\s*\(", "rev(Z_1, ", typed)
    try:
        eq = ast.parse(typed, mode="eval").body
        if (not isinstance(eq, ast.Compare) or len(eq.ops) != 1 or not isinstance(eq.ops[0], ast.Eq)
                or sum(1 for _ in ast.walk(eq)) > 256):
            return None
        lhs, rhs = eq.left, eq.comparators[0]
        for expr, literal in ((lhs, rhs), (rhs, lhs)):
            operands = _args(expr, "app", 2)
            if operands is None:
                continue
            patterns = []
            for operand in operands:
                reverse = _args(operand, "rev", 1)
                name = reverse[0] if reverse else operand
                if not isinstance(name, ast.Name) or name.id not in names or name.id in RESERVED:
                    break
                patterns.append((name.id, bool(reverse)))
            if len(patterns) != 2 or patterns[0][0] == patterns[1][0]:
                continue
            length, exact = list_length_bound(literal)
            if not exact or length > 12:
                continue
            whole = _numeral_list(literal, constants)
            if len(whole) == length:
                return patterns, tuple(whole)
    except (SyntaxError, Unsupported, RecursionError):
        pass
    return None


def expand_post(red, part, inherited, evidence, *, scope_check):
    """Expand all cuts in one required equality, within the current consequent only."""
    from .auto_definitions import expand_part, native_list

    names = qcp.existential_names(part)
    primitives = {"app", "rev", "cons", "nil", "Z_1"}
    if (len(names) >= 2 and len(set(names)) == len(names) and not primitives.intersection(names)
            and not primitives.intersection(inherited) and not primitives.intersection(red.defs)
            and "app" in part["pure"]):
        props = qcp.split_top(part["pure"], ";")
        for index, prop in enumerate(props):
            limits = _INTEGER_LIMITS.intersection(re.findall(r"\b[A-Za-z_]\w*\b", prop))
            if limits.intersection(red.defs) or limits.intersection(names) or limits.intersection(inherited):
                continue
            relation = _relation(prop, names, limits)
            if relation is None or not scope_check():
                continue
            patterns, whole = relation
            branches = []
            for cut in range(len(whole) + 1):
                # Concatenation forces the two images to be precisely this prefix
                # and suffix. Reverse is an involution, so each image has one
                # preimage. This finite disjunction is equivalent even for emp,
                # repeated elements, and multiple possible splits of the heap.
                equations = []
                images = (whole[:cut], whole[cut:])
                for (variable, reverse), image in zip(patterns, images):
                    witness = image[::-1] if reverse else image
                    equations.append(variable + " == " + native_list(witness))
                # Replace only the selected conjunct by its exact witness equations.
                # The ordinary reducer rechecks these and every other conjunct,
                # preserving each typed cell, local binding and sibling alternative.
                pure = props[:index] + equations + props[index + 1:]
                copied = (part["ex"] + "PROP[" + "; ".join(pure) + "]\nLOCAL[" + part["local"]
                          + "]\nSEP[" + part["spatial"] + "]\n")
                specialized, = qcp.assertion_parts(copied)
                branches.append(expand_part(red, specialized, inherited)[0])
            evidence.append({"equality": prop, "cuts": len(branches),
                             "binders": [name for name, _ in patterns],
                             "reversed": [reverse for _, reverse in patterns],
                             "checked_integer_notations": sorted(limits)})
            return "".join(branches)
    return expand_part(red, part, inherited)[0]
