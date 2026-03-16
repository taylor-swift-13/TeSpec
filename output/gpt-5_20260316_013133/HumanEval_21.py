from typing import List

def precondition(input) -> bool:
    try:
        import math
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        xs = input[0]
        if not isinstance(xs, list):
            return False
        if len(xs) < 2:
            return False
        mn = None
        mx = None
        for x in xs:
            if isinstance(x, bool):
                return False
            if not isinstance(x, (int, float)):
                return False
            xf = float(x)
            if math.isnan(xf) or math.isinf(xf):
                return False
            if mn is None or xf < mn:
                mn = xf
            if mx is None or xf > mx:
                mx = xf
        if mn is None or mx is None:
            return False
        if not (mn < mx):
            return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        import math
        from collections.abc import Sequence
        if not precondition(input):
            return True
        xs = input[0]
        if isinstance(output, Sequence) and not isinstance(output, (str, bytes, bytearray)):
            out_seq = list(output)
        else:
            try:
                out_seq = list(output)
            except Exception:
                return False
        if len(out_seq) != len(xs):
            return False
        vals = [float(x) for x in xs]
        mn = min(vals)
        mx = max(vals)
        den = mx - mn
        if not (den > 0.0 and math.isfinite(den)):
            return False
        for y, x in zip(out_seq, vals):
            if isinstance(y, bool):
                return False
            if not isinstance(y, (int, float)):
                return False
            yf = float(y)
            if math.isnan(yf) or math.isinf(yf):
                return False
            expected = (x - mn) / den
            if not math.isclose(yf, expected, rel_tol=1e-9, abs_tol=1e-9):
                return False
        ys = [float(y) for y in out_seq]
        if not (math.isclose(min(ys), 0.0, rel_tol=1e-9, abs_tol=1e-9) and math.isclose(max(ys), 1.0, rel_tol=1e-9, abs_tol=1e-9)):
            return False
        return True
    except Exception:
        return False

def _impl(numbers: List[float]) -> List[float]:
    """Given list of numbers (of at least two elements), apply a linear transform to that list,
    such that the smallest number will become 0 and the largest will become 1
    [0.0, 0.25, 0.5, 0.75, 1.0]"""
    ma, mi = max(numbers), min(numbers)
    k = 1 / (ma - mi)
    return list(map(lambda x: (x - mi) * k, numbers))

def rescale_to_unit(numbers: List[float]) -> List[float]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
