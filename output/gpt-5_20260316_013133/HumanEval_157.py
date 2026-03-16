
def precondition(input):
    import math
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    a, b, c = input
    def is_num(x):
        return isinstance(x, (int, float)) and not isinstance(x, bool) and math.isfinite(x)
    return is_num(a) and is_num(b) and is_num(c)

def postcondition(input, output):
    import math
    if not precondition(input):
        return True
    a, b, c = input
    if not isinstance(output, bool):
        return False
    if a <= 0 or b <= 0 or c <= 0:
        return output is False
    x, y, z = sorted((a, b, c))
    expected = math.isclose(z, math.hypot(x, y), rel_tol=1e-9, abs_tol=1e-12)
    return output == expected

def _impl(a, b, c):
    """Given the lengths of the three sides of a triangle. Return True if the three
    sides form a right-angled triangle, False otherwise.
    A right-angled triangle is a triangle in which one angle is right angle or 
    90 degree.
    Example:
    right_angle_triangle(3, 4, 5) == True
    right_angle_triangle(1, 2, 3) == False"""
    return a ** 2 + b ** 2 == c ** 2 or a ** 2 + c ** 2 == b ** 2 or b ** 2 + c ** 2 == a ** 2

def right_angle_triangle(a, b, c):
    _input = (a, b, c)
    assert precondition(_input)
    _output = _impl(a, b, c)
    assert postcondition(_input, _output)
    return _output
