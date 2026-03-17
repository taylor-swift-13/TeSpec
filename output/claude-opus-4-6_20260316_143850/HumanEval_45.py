
def precondition(input):
    try:
        a, h = input
        return (isinstance(a, (int, float)) and isinstance(h, (int, float))
                and a >= 0 and h >= 0)
    except Exception:
        return False


def postcondition(input, output):
    try:
        a, h = input
        expected = 0.5 * a * h
        return (isinstance(output, (int, float))
                and abs(output - expected) < 1e-9)
    except Exception:
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
