
import math

def precondition(input):
    # input should be a tuple of three positive finite numbers
    if not isinstance(input, tuple):
        return False
    if len(input) != 3:
        return False
    for v in input:
        if not isinstance(v, (int, float)):
            return False
        if not math.isfinite(v):
            return False
        if v <= 0:
            return False
    return True

def postcondition(input, output):
    # output should be a boolean indicating if input sides form a right triangle
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    if not isinstance(output, bool):
        return False
    a, b, c = input
    try:
        x = float(a)
        y = float(b)
        z = float(c)
    except:
        return False
    sides = sorted([x, y, z])
    p, q, r = sides
    tol = 1e-9 * max(1.0, r * r)
    expected = (p > 0) and abs(p * p + q * q - r * r) <= tol
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
