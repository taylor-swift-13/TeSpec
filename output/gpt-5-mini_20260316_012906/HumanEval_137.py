
import math
import re

def _is_str_real(s: str) -> bool:
    if not isinstance(s, str):
        return False
    s = s.strip()
    if s == "":
        return False
    # optional sign
    if s[0] in "+-":
        body = s[1:]
    else:
        body = s
    if body == "":
        return False
    # only digits and at most one decimal separator ('.' or ',')
    if body.count('.') + body.count(',') > 1:
        return False
    for ch in body:
        if not (ch.isdigit() or ch in ".,"):
            return False
    # must contain at least one digit
    if not any(ch.isdigit() for ch in body):
        return False
    return True

def _to_numeric(x):
    if isinstance(x, str):
        sx = x.strip().replace(',', '.')
        return float(sx)
    if isinstance(x, bool):
        # bools are not acceptable as numeric here
        raise ValueError("bool not supported")
    return float(x)

def precondition(args) -> bool:
    if not isinstance(args, tuple):
        return False
    if len(args) != 2:
        return False
    a, b = args
    # reject bools explicitly
    for v in (a, b):
        if isinstance(v, bool):
            return False
        if isinstance(v, int):
            continue
        if isinstance(v, float):
            if not math.isfinite(v):
                return False
            continue
        if isinstance(v, str):
            if not _is_str_real(v):
                return False
            # also ensure convertible
            try:
                _ = float(v.strip().replace(',', '.'))
            except Exception:
                return False
            continue
        return False
    return True

def postcondition(args, output) -> bool:
    if not precondition(args):
        return False
    a, b = args
    try:
        na = _to_numeric(a)
        nb = _to_numeric(b)
    except Exception:
        return False
    # use small tolerance for float comparisons
    tol = 1e-9
    if math.isfinite(na) is False or math.isfinite(nb) is False:
        return False
    # consider equal
    if math.isclose(na, nb, rel_tol=0.0, abs_tol=tol):
        return output is None
    # determine which is larger
    if na > nb + tol:
        # output must be the original a value in its original type
        return (output == a) and (type(output) is type(a))
    if nb > na + tol:
        return (output == b) and (type(output) is type(b))
    return False

def _impl(a, b):
    """Create a function that takes integers, floats, or strings representing
    real numbers, and returns the larger variable in its given variable type.
    Return None if the values are equal.
    Note: If a real number is represented as a string, the floating point might be . or ,

    compare_one(1, 2.5) ➞ 2.5
    compare_one(1, "2,3") ➞ "2,3"
    compare_one("5,1", "6") ➞ "6"
    compare_one("1", 1) ➞ None"""
    num_a = float(str(a).replace(",", "."))
    num_b = float(str(b).replace(",", "."))
    if num_a == num_b:
        return None
    return a if num_a > num_b else b

def compare_one(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
