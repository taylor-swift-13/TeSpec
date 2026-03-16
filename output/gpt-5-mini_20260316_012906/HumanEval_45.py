
import math
import numbers

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    a, h = input
    # both must be real numbers (exclude bool) and finite
    if not (isinstance(a, numbers.Real) and not isinstance(a, bool)):
        return False
    if not (isinstance(h, numbers.Real) and not isinstance(h, bool)):
        return False
    try:
        if math.isnan(a) or math.isnan(h) or math.isinf(a) or math.isinf(h):
            return False
    except (TypeError, ValueError):
        return False
    # lengths/heights should be non-negative
    if a < 0 or h < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    a, h = input
    # output must be a real finite number (exclude bool)
    if not (isinstance(output, numbers.Real) and not isinstance(output, bool)):
        return False
    try:
        if math.isnan(output) or math.isinf(output):
            return False
    except (TypeError, ValueError):
        return False
    expected = 0.5 * a * h
    return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-12)

def _impl(a, h):
    """Given length of a side and high return area for a triangle.
    7.5"""
    return a * h / 2

def triangle_area(a, h):
    _input = (a, h)
    assert precondition(_input)
    _output = _impl(a, h)
    assert postcondition(_input, _output)
    return _output
