
def precondition(args):
    if not isinstance(args, tuple) or len(args) != 2:
        return False
    a, h = args
    return isinstance(a, (int, float)) and isinstance(h, (int, float)) and a >= 0 and h >= 0

def postcondition(args, output):
    a, h = args
    if not isinstance(output, (int, float)):
        return False
    expected = 0.5 * a * h
    return abs(output - expected) < 1e-9

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
