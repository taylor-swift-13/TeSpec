
def precondition(input_args):
    if len(input_args) != 3:
        return False
    a, b, c = input_args
    return isinstance(a, (int, float)) and isinstance(b, (int, float)) and isinstance(c, (int, float)) and a > 0 and b > 0 and c > 0

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    a, b, c = input_args
    sides = sorted([a, b, c])
    # A right-angled triangle must satisfy the Pythagorean theorem
    # and must also be a valid triangle (sum of two shorter sides > longest side)
    is_triangle = sides[0] + sides[1] > sides[2]
    is_right = abs(sides[0]**2 + sides[1]**2 - sides[2]**2) < 1e-9
    expected = is_triangle and is_right
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
