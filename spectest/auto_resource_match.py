"""Prove a frozen exact entailment by reusing its separated resources."""
import re

import z3

from .auto_definitions import (
    ID, RESERVED, TYPES, Branch, definitions_for, frozen_bytes, product, require,
    split_operator, typ, unparen,
)
from .certificates import strip_comments
from .core import JobError
from .rocq_predicates import _application_parts
from tools.finite_spatial_smt.finite_spatial_smt import Unsupported


class _Sequent:
    def __init__(self, defs, visible):
        self.defs = defs
        self.visible = visible
        self.z = z3.IntSort()
        self.l = z3.DeclareSort("FrameList")
        self.sorts = {"Z": self.z, "list Z": self.l}
        self.functions = {
            "cons": z3.Function("FrameCons", self.z, self.l, self.l),
            "app": z3.Function("FrameApp", self.l, self.l, self.l),
        }
        self.plus = z3.Function("FramePlus", self.z, self.z, self.z)
        self.nil = z3.Const("FrameNil", self.l)
        self.reserved = RESERVED | set(defs) | set(self.functions) | set(TYPES) | {"_"}

    def bind(self, header, env, guards=None):
        witnesses = []
        for group in _application_parts(header):
            require(group.startswith("(") and group.endswith(")"), "unsupported_binder")
            name, sep, annotation = unparen(group).partition(":")
            name, annotation = name.strip(), annotation.strip()
            require(sep and re.fullmatch(ID, name) and name not in env and name not in self.reserved,
                    "ambiguous_binder")
            if guards is not None and re.fullmatch(r"PreH[0-9]+", name):
                # Dropping an unsupported guard strengthens the implication.
                try:
                    guards.append(self.prop(annotation, env))
                except Unsupported:
                    pass
                env[name] = None
            else:
                sort = self.sorts[typ(annotation)]
                env[name] = z3.FreshConst(sort, name)
                witnesses.append(env[name])
        return witnesses

    def term(self, text, env):
        term = unparen(text)
        if term in env and env[term] is not None:
            return env[term]
        if term == "@nil Z":
            return self.nil
        if re.fullmatch(r"[0-9]{1,32}", term):
            return z3.Int("FrameNumeral_" + term)
        if term in {"INT_MIN", "INT_MAX", "UINT_MAX"}:
            return z3.Int("FrameConstant_" + term)
        plus = split_operator(term, " + ")
        if plus:
            # Require an unambiguous binary application of Z.add.
            require(not split_operator(plus[1], " + "), "ambiguous_sum")
            a, b = (self.term(t, env) for t in plus)
            require(a.sort() == self.z and b.sort() == self.z, "invalid_sum")
            return self.plus(a, b)
        parts = _application_parts(term)
        require(len(parts) == 3 and parts[0] in self.functions, "unsupported_ground_term")
        return self.functions[parts[0]](*(self.term(p, env) for p in parts[1:]))

    def prop(self, text, env):
        term = unparen(text)
        for op in (" <> ", " = "):
            pair = split_operator(term, op)
            if pair:
                a, b = (self.term(p, env) for p in pair)
                require(a.sort() == b.sort(), "different_term_sorts")
                return a == b if op == " = " else a != b
        raise Unsupported("unsupported_guard")

    def formula(self, text, env):
        term = unparen(text)
        if term.startswith("EX "):
            header, body = split_operator(term[3:], ",")
            require(not split_operator(body, "||"), "ambiguous_disjunction_scope")
            local = env.copy()
            witnesses = self.bind(header, local)
            branches = self.formula(body, local)
            for branch in branches:
                branch.exists.extend(witnesses)
            return branches
        for op in ("||", "&&", "**"):
            pair = split_operator(term, op, stop_at_binder=True)
            if pair:
                left, right = (self.formula(p, env) for p in pair)
                if op == "||":
                    require(len(left) + len(right) <= 32, "disjunction_budget")
                    return left + right
                return product(left, right, op)
        if term.startswith("“") and term.endswith("”"):
            return [Branch([self.prop(term[1:-1], env)], [], [], False)]
        if term == "emp":
            return [Branch([], [], [], True)]
        cell = re.fullmatch(r"(.+?)\s*#\s*(\w+)\s*\|->\s*(.+)", term)
        if cell:
            name = "#" + cell[2]
            require(cell[2] in TYPES, "unsupported_cell")
            args = [self.term(cell[i], env) for i in (1, 3)]
            sorts = [self.z, self.z]
        else:
            name, *terms = _application_parts(term)
            require(name in self.visible and name in self.defs and self.defs[name].result == "Assertion",
                    "unbound_spatial_predicate")
            args = [self.term(t, env) for t in terms]
            sorts = [self.sorts[t] for _, t in self.defs[name].args]
        require(len(args) == len(sorts) and all(a.sort() == s for a, s in zip(args, sorts)), "ill_typed_atom")
        return [Branch([], [(name, args)], [], True)]


def _pairings(post, pre, limit):
    if not post:
        yield []
        return
    for i, (name, args) in enumerate(pre):
        if name == post[0][0]:
            limit[0] -= 1
            require(limit[0] >= 0, "resource_matching_budget")
            for rest in _pairings(post[1:], pre[:i] + pre[i + 1:], limit):
                yield list(zip(post[0][1], args)) + rest


def _consequence(pre, post, guards, timeout_ms):
    require(pre.exact and not pre.exists and len(pre.cells) <= 20, "unsupported_antecedent")
    choices = []
    limit = [1024]
    for branch in post:
        if not branch.exact or len(pre.cells) != len(branch.cells):
            continue
        for pairs in _pairings(branch.cells, pre.cells, limit):
            replacements = []
            for witness in branch.exists:
                value = next((a for b, a in pairs if z3.eq(b, witness)), None)
                if value is None:
                    break
                replacements.append((witness, value))
            else:
                claim = z3.And(*branch.pure, *(a == b for a, b in pairs))
                choices.append(z3.substitute(claim, *replacements))
    if not choices:
        return False
    solver = z3.Solver()
    solver.set(timeout=timeout_ms)
    solver.add(*guards, *pre.pure, z3.Not(z3.Or(*choices)))
    return solver.check() == z3.unsat


def _prove(body, defs, visible, timeout_ms):
    require(body.startswith("forall ") and len(body) <= 32768, "unsupported_original_goal")
    header, formula = split_operator(body[7:], ",")
    lhs, rhs = split_operator(formula, "|--")
    seq = _Sequent(defs, visible)
    env, guards = {}, []
    seq.bind(header, env, guards)
    pre, = seq.formula(lhs, env)
    post = seq.formula(rhs, env)
    return _consequence(pre, post, guards, timeout_ms)


def prove_original_resources(case, record, timeout_ms):
    """Positive-only rule. Each consequent witness denotes a term from the antecedent."""
    try:
        roots = record["vc"].get("proof_roots")
        require(record.get("check_mode") == "exact" and isinstance(roots, list) and 0 < len(roots) <= 8, "unmapped_entailment")
        defs, layout, visible = definitions_for(case)
        require(layout == record["layout"], "layout_mismatch")
        manifest = case["vc"]
        sha = manifest["immutable_sha256"]["goal"]
        source = strip_comments(frozen_bytes(manifest["files"]["goal"], sha).decode())
        for root in roots:
            require(re.fullmatch(ID, root), "invalid_root")
            match, = re.finditer(r"^Definition " + re.escape(root) + r"\s*:=\s*(.*?)\.(?=\s|$)",
                                  source, re.M | re.S)
            # Admit only earlier printer-generated definitions in the frozen goal.
            prefix = source[:match.start()].split("\nDefinition ", 1)
            if len(prefix) == 2:
                commands = re.split(r"\.(?=\s|$)", "Definition " + prefix[1])
                require(all(re.match(r"Definition\s+" + ID + r"\s*:=", c.strip())
                            for c in commands if c.strip()), "changed_goal_context")
            require(_prove(" ".join(match[1].split()), defs, visible, timeout_ms), "resource_match_unproved")
        return {"status": "VALID", "reason": "original_separated_resources_match",
                "proof_roots": roots, "goal_sha256": sha}
    except (Unsupported, JobError, OSError, ValueError, KeyError, TypeError, RecursionError, z3.Z3Exception):
        return None
