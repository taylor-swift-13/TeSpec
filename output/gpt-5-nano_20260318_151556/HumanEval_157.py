
import math

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    a, b, c = input
    for t in (a, b, c):
        if not isinstance(t, (int, float)):
            return False
        if not math.isfinite(t):
            return False
        if t <= 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    a, b, c = input
    sides = sorted((a, b, c))
    x, y, z = sides
    tol = 1e-9
    expected = abs(x*x + y*y - z*z) <= tol * max(1.0, x*x + y*y, z*z)
    return output == expected

def _impl(a, b, c):
    """
    Given the lengths of the three sides of a triangle. Return True if the three
    sides form a right-angled triangle, False otherwise.
    A right-angled triangle is a triangle in which one angle is right angle or 
    90 degree.
    Example:
    right_angle_triangle(3, 4, 5) == True
    right_angle_triangle(1, 2, 3) == False
    """
    return a ** 2 + b ** 2 == c ** 2 or a ** 2 + c ** 2 == b ** 2 or b ** 2 + c ** 2 == a ** 2

def right_angle_triangle(a, b, c):
    _input = (a, b, c)
    assert precondition(_input)
    _output = _impl(a, b, c)
    assert postcondition(_input, _output)
    return _output
