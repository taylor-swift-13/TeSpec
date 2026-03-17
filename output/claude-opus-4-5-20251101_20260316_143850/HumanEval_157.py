
def precondition(input):
    if len(input) != 3:
        return False
    a, b, c = input
    # Check that all inputs are numeric (int or float)
    if not all(isinstance(x, (int, float)) for x in [a, b, c]):
        return False
    # Check that all sides are positive
    if not (a > 0 and b > 0 and c > 0):
        return False
    # Check that the sides can form a valid triangle (triangle inequality)
    if not (a + b > c and a + c > b and b + c > a):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    a, b, c = input
    # Check if it's a right-angled triangle using Pythagorean theorem
    # Need to account for floating point precision
    epsilon = 1e-9
    sides = sorted([a, b, c])
    is_right = abs(sides[0]**2 + sides[1]**2 - sides[2]**2) < epsilon
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
