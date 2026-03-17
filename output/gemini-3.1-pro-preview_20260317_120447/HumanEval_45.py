
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    a, h = input
    return isinstance(a, (int, float)) and isinstance(h, (int, float))

def postcondition(input, output) -> bool:
    a, h = input
    if not isinstance(output, (int, float)):
        return False
    expected = 0.5 * a * h
    return abs(output - expected) <= 1e-5 + 1e-9 * abs(expected)

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
