"""Refute original disjunctions of exact entailments with disjoint heap sizes."""
import hashlib
import re
from pathlib import Path

import z3

from .auto_definitions import (
    Branch, ID, RESERVED, Reduction, TYPES, QCP_INTEGER_PRELUDE, _QCP_ADDRESS_PRELUDE,
    definitions_for, frozen_bytes, require, split_operator,
    unparen, write_branch,
)
from .certificates import strip_comments
from .core import JobError, _C_COMMENT_PATTERN, _c_parameters, _consume_balanced, _function_specs
from .rocq_predicates import _application_parts
from tools.finite_spatial_smt import qcp_import
from tools.finite_spatial_smt.finite_spatial_smt import Unsupported, encode, type_info


# The concrete naive STS model uses exact singleton byte heaps. Undefined
# storage admits either a Noninit byte or an initialized byte. Pin its notation
# and definitions before interpreting either form as ownership of one byte.
_PARENT_RUNTIME = {
    **_QCP_ADDRESS_PRELUDE,
    **QCP_INTEGER_PRELUDE,
    "ConAssertion.v": "0f96886c3a0251e4e97cf879d0617950f4e0fbc067a713dc8560af4784b4463b",
    "CommonAssertion.v": "3a535b7562b99400eb3432860173aebf1722494d9d411c8efaa80b2b306e1738",
}


class _ExactAssertions(Reduction):
    def __init__(self, layout, escaped_parameter):
        super().__init__({}, layout, set())
        self.escaped_parameter = escaped_parameter
        self.post = False

    def term(self, text, env, depth):
        parts = _application_parts(unparen(text))
        if len(parts) == 3 and parts[0] == "unsigned_last_nbits":
            value = self.term(parts[1], env, depth + 1)
            width = unparen(parts[2])
            require(isinstance(value, str) and re.fullmatch(r"\d{1,3}", width)
                    and int(width) <= 128, "unsupported_bit_width")
            return f"(({value}) % {1 << int(width)})"
        return super().term(text, env, depth)

    def formula(self, text, env, depth, lists=frozenset()):
        t = unparen(text)
        if t == "TT":
            return [Branch(["True"], [], [], False)]
        # A callee parameter has expired when the caller observes the returned
        # address. Its address need never be assigned. Only count its required
        # bytes, which are necessary for every interpretation of that address.
        cell = re.fullmatch(r"(.+?)\s*#\s*(" + "|".join(TYPES) + r")\s*\|->\s*(.+)", t)
        if cell:
            address = unparen(cell[1])
            local = re.fullmatch(r'&\(\s*"([A-Za-z_]\w*)_spec_\d+"\s*\)', address)
            if local:
                require(self.post and local[1] == self.escaped_parameter, "unbound_stack_address")
                # This placeholder is used solely for counting the right-hand
                # type's width; no RHS satisfiability/countermodel uses it.
                address = "0"
            if cell[3].strip() == "_":
                addr = self.term(address, env, depth + 1)
                return [Branch([], [f"has_permission({addr}, {TYPES[cell[2]]})"], [], True)]
            if local:
                t = f"0 # {cell[2]} |-> {cell[3]}"
        return super().formula(t, env, depth, lists)


def _straight_line_source(source):
    # A refuted abstract entailment on a branch is not itself an execution
    # witness. Restrict this rule to the unbranched scalar C fragment until
    # path reachability and private aggregate frames can be reconstructed.
    code = re.sub(r'(?m)^[ \t]*#\s*include\s*"verification_stdlib\.h"[ \t]*$', "", source)
    code = re.sub(_C_COMMENT_PATTERN, " ", code, flags=re.S)
    if re.search(
        r"\b(?:if|else|while|do|for|switch|goto|struct|union|typedef|setjmp|longjmp)\b"
        r'|[?#\\]|&&|\|\||["\x27]|\)\s*\(', code,
    ):
        return False
    # Exclude recursion as well as explicit loops. Accept only ordinary C
    # function bodies without nested blocks, and check calls between them.
    functions = re.findall(r"\b(" + ID + r")\s*\([^;{}]*\)\s*\{([^{}]*)\}", code)
    if code.count("{") != len(functions) or not functions:
        return False
    calls = {name: set(re.findall(r"\b(" + ID + r")\s*\(", body))
             for name, body in functions}
    pending = {name: deps & calls.keys() for name, deps in calls.items()}
    while pending:
        leaves = {name for name, deps in pending.items() if not deps}
        if not leaves:
            return False
        pending = {name: deps - leaves for name, deps in pending.items() if name not in leaves}
    return True


def _escaped_parameter(source, function):
    """Match a definition that directly returns an automatic parameter's address."""
    specs = _function_specs(source, function)
    if not specs:
        return None
    spec = specs[-1]
    tail = source[spec.end:].lstrip()
    body = re.match(r"\{\s*return\s+&\s*(" + ID + r")\s*;\s*\}", tail)
    if not body or body[1] not in {p.name for p in _c_parameters(spec)}:
        return None
    # An exact points-to resource on __return makes the address observable.
    # Only a mandatory top-level separating conjunct establishes this
    # ownership requirement. A points-to buried in an implication or
    # alternative postcondition would not suffice.
    for candidate in specs:
        _, ensure, post = candidate.body.partition("Ensure")
        if not ensure or re.search(r"\|\||=>|\?|\b(?:exists|forall|or)\b", post, re.I):
            return None
        conj = unparen(post)
        while True:
            pair = split_operator(conj, "*")
            head = unparen(pair[0] if pair else conj)
            if re.fullmatch(r"data_at\s*\(\s*__return\s*,[^(),]+,\s*"
                            + re.escape(body[1]) + r"\s*\)", head):
                break
            if not pair:
                return None
            conj = pair[1]
    return body[1]


def _parent_arms(goal, root, layout, escaped_parameter):
    name = root.removeprefix("proof_of_")
    clean = strip_comments(goal)
    prefix = clean.split("Definition " + name + " :=", 1)[0]
    commands = [" ".join(c.split()) for c in re.split(r"\.(?=\s|$)", prefix) if c.strip()]
    header = ["From SimpleC.Verification Require Import VCPrelude", "Import " + layout["memory_rules"],
              "Local Open Scope sac", "Local Open Scope Z_scope"]
    require(commands[:4] == header, "unbound_original_notation")
    for prior in commands[4:]:
        decl = re.match(r"Definition (\w+)\s*:=", prior)
        require(decl and decl[1] not in RESERVED | {"unsigned_last_nbits"}, "unbound_original_command")
    definitions = re.findall(r"^Definition\s+" + re.escape(name) + r"\s*:=\s*(.*?)\.(?=\s|$)",
                             clean, re.M | re.S)
    require(len(definitions) == 1, "unbound_parent")
    arms = re.split(r"(?m)^\)\s*\\/\s*\(\s*$", definitions[0].strip())
    require(2 <= len(arms) <= 16 and arms[0].startswith("(") and arms[-1].endswith(")"),
            "unknown_original_disjunction")
    arms[0] = arms[0][1:]
    arms[-1] = arms[-1][:-1]
    common_names = None
    for arm in arms:
        quantified = unparen(arm)
        require(quantified.startswith("forall ") and "\\/" not in quantified, "unknown_original_arm")
        header, formula = split_operator(quantified[7:], ",")
        names, guards, bound = {}, [], set()
        reduction = _ExactAssertions(layout, escaped_parameter)
        while header:
            binder, end = _consume_balanced(header, 0, "(", ")")
            header = header[end:].strip()
            symbol, colon, typ = binder.partition(":")
            symbol, typ = symbol.strip(), typ.strip()
            require(colon and re.fullmatch(ID, symbol) and symbol not in bound
                    and symbol not in RESERVED | {"unsigned_last_nbits"} and not symbol.startswith(("tespec_", "__fsm_")),
                    "unsupported_original_binder")
            bound.add(symbol)
            if typ == "Z":
                names[symbol] = symbol
            else:
                require(re.fullmatch(r"PreH\d+", symbol), "unsupported_original_guard")
                guards.append(reduction.prop(typ, names, 0))
        require(common_names is None or common_names == names, "incompatible_parent_binders")
        common_names = names
        sides = formula.split("|--")
        require(len(sides) == 2, "expected_entailment")
        lhs, = reduction.formula(sides[0], names, 0)
        require(lhs.exact, "nonexact_pre")
        lhs.pure.extend(guards)
        pre, = qcp_import.assertions(write_branch(lhs))
        reduction.post = True
        posts = reduction.formula(sides[1], names, 0)
        require(posts and all(b.exact for b in posts), "nonexact_post")
        post = qcp_import.assertions("".join(write_branch(b) for b in posts))
        yield pre, post, names


def _footprint(heap, bits):
    require(all(c["kind"] == "cell" for c in heap["spatial"]), "noncell_heap")
    return sum(type_info(c["type"], bits).size for c in heap["spatial"])


def refute_parent_by_footprint(case, function, goal, root, kind, timeout_ms):
    """Witness every false disjunct on its own exact heap at common scalar bindings.

    The caller has already checked native root identity, diagnostic INVALID, and
    private-frame guards. Local addresses in a live annotation are out of scope.
    """
    if kind not in {"return", "entailment", "which_implies"}:
        return None
    try:
        vc = case["vc"]
        require(hashlib.sha256(goal.encode()).hexdigest() == vc["immutable_sha256"]["goal"],
                "original_goal_changed")
        defs, layout, _ = definitions_for(case)
        require(not defs, "nonstandard_parent_environment")
        lib = Path(vc["qcip_root"]) / "SeparationLogic/SeparationLogic"
        require(layout["architecture_bits"] == 32 and layout["memory_rules"] == "naive_C_Rules",
                "unbound_memory_rules")
        for file, digest in _PARENT_RUNTIME.items():
            frozen_bytes(lib / file, digest)
        source = Path(case["generated_source"]).read_bytes()
        require(hashlib.sha256(source).hexdigest() == case["generated_source_sha256"],
                "source_changed")
        source_text = source.decode()
        require(_straight_line_source(source_text), "unwitnessed_control_flow_or_frame")
        escaped = _escaped_parameter(source_text, function) if kind == "return" else None
        terms = list(_parent_arms(goal, root, layout, escaped))
        ir_layout = {k: layout[k] for k in ("architecture_bits", "memory_rules", "byte_order")}
        bits = ir_layout["architecture_bits"]
        solver = z3.Solver()
        solver.set(timeout=timeout_ms)
        witnesses = []
        symbols = {}
        for i, (pre, posts, _) in enumerate(terms):
            before = _footprint(pre, bits)
            after = [_footprint(post, bits) for post in posts]
            require(before not in after, "compatible_heap_sizes")
            enc = encode({"layout": ir_layout, "mode": "exact", "pre": [pre], "post": []})
            # Each universally quantified entailment can be refuted on a
            # different heap. Keep shared integer inputs identical, isolate
            # all heap arrays and local existential witnesses across the arms.
            private = [enc.owned, enc.initialized, enc.memory, *enc.witnesses.values()]
            substitutions = [(v, z3.FreshConst(v.sort(), f"parent_arm_{i}")) for v in private]
            solver.add(z3.substitute(enc.pre, *substitutions))
            symbols.update(enc.variables)
            addresses = [z3.substitute(a, *substitutions) for a in enc.pre_addresses]
            solver.add(*[a > 0 for a in addresses])
            memory = substitutions[2][1]
            init = substitutions[1][1]
            local_values = {name: z3.substitute(v, *substitutions) for name, v in enc.witnesses.items()}
            witnesses.append((before, after, addresses, memory, init, local_values))
        if solver.check() != z3.sat:
            return None
        model = solver.model()
        def integer(expr):
            return model.eval(expr, model_completion=True).as_long()

        arms = []
        for before, after, addresses, memory, init, local_values in witnesses:
            heap = []
            for a in addresses:
                heap.append([integer(a), integer(z3.Select(memory, a)),
                             z3.is_true(model.eval(z3.Select(init, a), model_completion=True))])
            arm = {"pre_bytes": before, "required_post_bytes": after, "heap": sorted(heap)}
            if local_values:
                arm["local_witnesses"] = {name: integer(v) for name, v in local_values.items()}
            arms.append(arm)
        return {"root": root, "method": "exact_heap_cardinality", "goal_sha256": vc["immutable_sha256"]["goal"],
                "bindings": {name: integer(value) for name, value in symbols.items()}, "arms": arms}
    except (Unsupported, JobError, KeyError, TypeError, ValueError, OSError, RecursionError, z3.Z3Exception):
        return None
