
def precondition(input) -> bool:
    try:
        a, h = input
    except Exception:
        return False
    try:
        import math
    except Exception:
        return False
    if not isinstance(a, (int, float)) or not isinstance(h, (int, float)):
        return False
    if not (math.isfinite(a) and math.isfinite(h)):
        return False
    if a < 0 or h < 0:
        return False
    return True

def postcondition(input, output) -> bool:
    try:
        a, h = input
    except Exception:
        return True
    if not precondition(input):
        return True
    import math
    if not isinstance(output, (int, float)):
        return False
    if not math.isfinite(output):
        return False
    expected = 0.5 * a * h
    return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-9)

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
