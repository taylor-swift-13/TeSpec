"""Check a sufficient existential instance against the complete finite heap."""
import json
import re
import time

import z3

from tools.finite_spatial_smt.finite_spatial_smt import Expressions, encode, integer


_IDENTIFIER = re.compile(r"\b[A-Za-z_]\w*\b")


def substitute(term, bindings):
    if not isinstance(term, str):
        return term
    # Simultaneous substitution. Witness values have antecedent scope, even
    # when a free identifier there has the spelling of a consequent binder.
    return _IDENTIFIER.sub(lambda m: "(" + str(bindings[m[0]]) + ")" if m[0] in bindings else m[0], term)


def check_cell_witnesses(ir, timeout_ms):
    """Follow typed cells from known addresses. Only UNSAT proves the original VC."""
    started = time.monotonic()
    if len(ir["pre"]) != 1:
        return None
    (left,) = ir["pre"]
    if not left["spatial"] or any(cell["kind"] != "cell" for cell in left["spatial"]):
        return None
    # (exists u, P(u)) entails Q iff P(fresh u) entails Q for every fresh u.
    prefix = "tespec_heap_witness_pre_"
    if prefix in json.dumps(ir):
        return None
    fresh = {name: prefix + str(i) for i, name in enumerate(left["exists"])}
    expressions = Expressions()

    def address_key(cell, bindings):
        address = substitute(cell["address"], bindings)
        return cell["type"], z3.simplify(integer(expressions.parse(address))).sexpr()

    sources = {address_key(cell, fresh): (i, substitute(cell.get("value"), fresh))
               for i, cell in enumerate(left["spatial"])}
    if len(sources) != len(left["spatial"]):
        return None

    validated = False
    deadline = started + timeout_ms / 1000
    for index, right in enumerate(ir["post"]):
        cells = right["spatial"]
        names = set(right["exists"])
        if (not names or not cells or any(cell["kind"] != "cell" for cell in cells)
                or (ir["mode"] == "exact" and len(cells) != len(sources))):
            continue
        bindings = {}
        while names - bindings.keys():
            previous = len(bindings)
            for cell in cells:
                value = str(cell.get("value")).strip("() ")
                if value not in names or value in bindings:
                    continue
                if (names - bindings.keys()).intersection(_IDENTIFIER.findall(str(cell["address"]))):
                    continue
                source = sources.get(address_key(cell, bindings))
                if source and source[1] is not None:
                    bindings[value] = source[1]
            if len(bindings) == previous:
                break
        if bindings.keys() != names:
            continue
        # Sepcon is commutative. Use the same order for the two finite
        # footprint arrays, keeping every original cell and pure constraint.
        keys = [address_key(cell, bindings) for cell in cells]
        if not all(key in sources for key in keys):
            continue
        # Keep the actual quantified body's pure formulas, cells, and binder
        # scopes. String matching above proposes a witness only. Instantiate
        # the typed Z3 body with its actual antecedent Skolem constants.
        if not validated:
            encode(ir, eliminate_value_witnesses=False)  # validate every original alternative
            validated = True
        order = sorted(range(len(keys)), key=lambda i: sources[keys[i]][0])
        ordered = right | {"spatial": [cells[i] for i in order]}
        enc = encode(ir | {"post": [ordered]}, eliminate_value_witnesses=False)
        quant = enc.post.arg(0)
        if not z3.is_quantifier(quant) or not quant.is_exists() or quant.num_vars() != len(right["exists"]):
            return None
        scope = {alias: enc.witnesses["pre0::" + name] for name, alias in fresh.items()}
        terms = [integer(expressions.parse(bindings[name], scope)) for name in right["exists"]]
        body = z3.substitute_vars(quant.body(), *reversed(terms))
        solver = z3.Solver()
        remaining_ms = int((deadline - time.monotonic()) * 1000)
        if remaining_ms <= 0:
            return None
        solver.set(timeout=remaining_ms)
        solver.add(z3.simplify(z3.And(enc.pre, z3.Not(body))))
        if solver.check() != z3.unsat:
            continue
        # Retain a replayable unsimplified formula with the entire heap.
        audit = z3.Solver()
        audit.add(enc.pre, z3.Not(body))
        consistent = z3.Solver()
        consistent.set(timeout=timeout_ms)
        consistent.add(enc.pre)
        sat = consistent.check()
        return {"status": "VALID", "reason": "counterexample_query_unsat", "supported": True,
                "solver_result": "unsat", "smt2": audit.to_smt2(), "scope": "spatial_vc_only",
                "certificate": "NOT_CHECKED", "antecedent_satisfiability": str(sat),
                "vacuous": sat == z3.unsat, "wall_seconds": time.monotonic() - started,
                "heap_witnesses": {"post_alternative": index, "antecedent_eigenvariables": fresh,
                                   "bindings": bindings}}
    return None
