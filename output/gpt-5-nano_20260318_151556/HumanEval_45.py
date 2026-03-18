
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, h = input
    try:
        a_f = float(a)
        h_f = float(h)
    except (TypeError, ValueError):
        return False
    from math import isfinite
    if not (isfinite(a_f) and isfinite(h_f)):
        return False
    if a_f < 0 or h_f < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, h = input
    try:
        a_f = float(a)
        h_f = float(h)
        o_f = float(output)
    except (TypeError, ValueError):
        return False
    from math import isfinite
    if not (isfinite(a_f) and isfinite(h_f) and isfinite(o_f)):
        return False
    expected = (a_f * h_f) / 2.0
    tol = 1e-9 * max(1.0, abs(expected))
    return abs(o_f - expected) <= tol

def _impl(a, h):
    """
    Given length of a side and high return area for a triangle.
    7.5
    """
    return a * h / 2

def triangle_area(a, h):
    _input = (a, h)
    assert precondition(_input)
    _output = _impl(a, h)
    assert postcondition(_input, _output)
    return _output
