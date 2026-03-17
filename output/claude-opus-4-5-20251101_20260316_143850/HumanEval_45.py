
def precondition(input):
    if len(input) != 2:
        return False
    a, h = input
    # Both side length and height must be numeric (int or float)
    if not isinstance(a, (int, float)) or not isinstance(h, (int, float)):
        return False
    # Exclude NaN and infinity
    if isinstance(a, float) and (a != a or abs(a) == float('inf')):
        return False
    if isinstance(h, float) and (h != h or abs(h) == float('inf')):
        return False
    # Side length and height must be non-negative for a valid triangle area
    if a < 0 or h < 0:
        return False
    return True


def postcondition(input, output):
    a, h = input
    # Output must be numeric
    if not isinstance(output, (int, float)):
        return False
    # Area of triangle is (base * height) / 2
    expected = (a * h) / 2
    # Allow small floating point tolerance
    if abs(output - expected) > 1e-9:
        return False
    # Area must be non-negative
    if output < 0:
        return False
    return True

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
