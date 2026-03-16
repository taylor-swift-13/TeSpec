
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 3:
        return False
    for x in input:
        # reject booleans
        if isinstance(x, bool):
            return False
        if not isinstance(x, (int, float)):
            return False
        if not math.isfinite(x):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    a, b, c = input
    valid = (a + b > c) and (a + c > b) and (b + c > a)
    if not valid:
        return output == -1
    s = (a + b + c) / 2.0
    prod = s * (s - a) * (s - b) * (s - c)
    prod = max(prod, 0.0)
    area = math.sqrt(prod)
    expected = round(area, 2)
    if isinstance(output, bool):
        return False
    if not isinstance(output, (int, float)):
        return False
    return abs(float(output) - expected) <= 1e-9

def _impl(a, b, c):
    """Given the lengths of the three sides of a triangle. Return the area of
    the triangle rounded to 2 decimal points if the three sides form a valid triangle. 
    Otherwise return -1
    Three sides make a valid triangle when the sum of any two sides is greater 
    than the third side.
    Example:
    triangle_area(3, 4, 5) == 6.00
    triangle_area(1, 2, 10) == -1"""
    if a + b <= c or a + c <= b or b + c <= a: return -1
    p = (a + b + c) / 2
    return round((p * (p - a) * (p - b) * (p - c)) ** 0.5, 2)

def triangle_area(a, b, c):
    _input = (a, b, c)
    assert precondition(_input)
    _output = _impl(a, b, c)
    assert postcondition(_input, _output)
    return _output
