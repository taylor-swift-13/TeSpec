
def precondition(input):
    a, b, c = input
    return all(isinstance(x, (int, float)) and x > 0 for x in [a, b, c])

def postcondition(input, output):
    a, b, c = input
    sides = sorted([a, b, c])
    is_right = abs(sides[0]**2 + sides[1]**2 - sides[2]**2) < 1e-9
    return output == is_right

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
