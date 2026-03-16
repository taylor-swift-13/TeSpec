
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
        if isinstance(x, float) and (math.isnan(x) or math.isinf(x)):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    l = input[0]
    if not isinstance(output, (int, float)):
        return False
    if isinstance(output, float) and (math.isnan(output) or math.isinf(output)):
        return False
    s = sorted(l)
    n = len(s)
    if n % 2 == 1:
        expected = s[n // 2]
    else:
        expected = (s[n // 2 - 1] + s[n // 2]) / 2.0
    try:
        return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-12)
    except Exception:
        return False

def _impl(l: list):
    """Return median of elements in the list l.
    3
    15.0"""
    sorted_l = sorted(l)
    if len(l) % 2 == 1:
        return sorted_l[len(l) // 2]
    else:
        return (sorted_l[len(l) // 2 - 1] + sorted_l[len(l) // 2]) / 2

def median(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
