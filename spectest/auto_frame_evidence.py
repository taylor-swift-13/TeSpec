"""Concrete countermodel search for finite exact-heap entailments in Auto."""
import time

import z3

from tools.finite_spatial_smt.finite_spatial_smt import Unsupported, check, encode, type_info


def _owned_bytes(alternative, bits):
    total = 0
    for atom in alternative["spatial"]:
        width = type_info(atom["type"], bits).size
        if atom["kind"] == "cell":
            total += width
        elif atom["kind"] == "array":
            total += width * atom["length"]
        else:
            raise Unsupported("unsupported_finite_footprint")
    return total


def _array_with_default(default, pairs):
    array = z3.K(z3.IntSort(), default)
    for address, value in pairs:
        array = z3.Store(array, address, value)
    return array


def _mismatched_footprints(ir):
    if not isinstance(ir, dict) or ir.get("mode") != "exact":
        return None
    pre, post = ir.get("pre"), ir.get("post")
    if not isinstance(pre, list) or not pre or not isinstance(post, list):
        return None
    if not any(isinstance(arm, dict) and arm.get("exists") for arm in post):
        return None
    # Only inspect the syntactic hint here. Malformed input goes through the
    # original check so that its schema error and status are preserved.
    try:
        bits = ir["layout"]["architecture_bits"]
        pre_bytes = [_owned_bytes(a, bits) for a in pre]
        post_bytes = [_owned_bytes(a, bits) for a in post]
    except (Unsupported, KeyError, TypeError):
        return None
    if set(pre_bytes).intersection(post_bytes):
        return None
    return pre_bytes, post_bytes


def check_exact_countermodel(ir, *, timeout_ms, include_smt=False):
    """A size mismatch suggests a model. Only SAT of the complete VC accepts it."""
    footprints = _mismatched_footprints(ir)
    if footprints is None:
        return None
    return _replay(ir, footprints, timeout_ms, include_smt)


def _replay(ir, footprints, timeout_ms, include_smt):
    started = time.monotonic()
    pre_bytes, post_bytes = footprints
    # Validate ALL original arms before looking for a witness. In exact mode
    # each satisfiable separating conjunction owns precisely its byte count.
    try:
        enc = encode(ir)
    except Unsupported:
        return None
    available = timeout_ms - int(1000 * (time.monotonic() - started))
    if available <= 0:
        return None
    candidate = check(ir | {"post": []}, timeout_ms=max(1, available // 2))
    if candidate["status"] != "INVALID":
        return None
    witness = candidate["countermodel"]
    heap = witness["heap"]

    # Freeze one memory, including unowned bytes, for every consequent. Free
    # globals that occur only on the right can be chosen by this actual replay.
    solver = z3.Solver()
    solver.add(enc.query)
    solver.add(enc.owned == _array_with_default(z3.BoolVal(False),
               ((cell["address"], True) for cell in heap)))
    solver.add(enc.initialized == _array_with_default(z3.BoolVal(False),
               ((cell["address"], True) for cell in heap if cell["initialized"])))
    solver.add(enc.memory == _array_with_default(z3.IntVal(0),
               ((cell["address"], cell["byte"]) for cell in heap if cell["byte"])))
    for name, value in witness["variables"].items():
        solver.add(enc.variables[name] == value)
    for name, value in witness["pre_witnesses"].items():
        solver.add(enc.witnesses[name] == value)
    remaining = timeout_ms - int(1000 * (time.monotonic() - started))
    if remaining <= 0:
        return None
    solver.set(timeout=remaining)
    if solver.check() != z3.sat:
        return None
    model = solver.model()
    witness["variables"] = {name: model.eval(var, model_completion=True).as_long()
                            for name, var in enc.variables.items()}
    result = candidate | {
        "countermodel": witness,
        "exact_footprint_replay": {
            "pre_owned_bytes": pre_bytes, "post_owned_bytes": post_bytes,
            "concrete_owned_bytes": len(heap), "original_query_result": "sat",
        },
        "wall_seconds": time.monotonic() - started,
    }
    if include_smt:
        result["smt2"] = solver.to_smt2()
    return result


def check_auto_heap(ir, *, timeout_ms, include_smt=False, match_pre_witnesses=False):
    footprints = _mismatched_footprints(ir)
    if footprints is None:
        return check(ir, timeout_ms=timeout_ms, include_smt=include_smt,
                     match_pre_witnesses=match_pre_witnesses)

    started = time.monotonic()
    # Reserve at least half of the solver budget for the general algorithm.
    # Charge an unsuccessful replay to the same budget and reported duration.
    decided = _replay(ir, footprints, max(1, timeout_ms // 2), include_smt)
    if decided is not None:
        return decided
    remaining = max(1, timeout_ms - int(1000 * (time.monotonic() - started)))
    result = check(ir, timeout_ms=remaining, include_smt=include_smt,
                   match_pre_witnesses=match_pre_witnesses)
    result["wall_seconds"] = time.monotonic() - started
    return result
