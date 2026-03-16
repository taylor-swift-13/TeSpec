
def precondition(input):
    # Expect a tuple (a, h) with non-negative real numbers
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    a, h = input
    if not isinstance(a, (int, float)) or not isinstance(h, (int, float)):
        return False
    if a < 0 or h < 0:
        return False
    return True

def postcondition(input, output):
    # Output should be 0.5 * a * h for input (a, h)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, h = input
    if not isinstance(a, (int, float)) or not isinstance(h, (int, float)):
        return False
    if not isinstance(output, (int, float)):
        return False
    expected = 0.5 * a * h
    tol = 1e-9
    if abs(output - expected) <= tol * max(1.0, abs(expected)):
        return True
    return False

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
