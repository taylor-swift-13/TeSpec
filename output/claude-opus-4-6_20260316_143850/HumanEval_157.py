
def precondition(input):
    a, b, c = input
    # All sides must be numeric (int or float) and positive
    if not all(isinstance(x, (int, float)) for x in [a, b, c]):
        return False
    if any(x != x for x in [a, b, c]):  # NaN check
        return False
    if a <= 0 or b <= 0 or c <= 0:
        return False
    return True


def postcondition(input, output):
    a, b, c = input
    if not isinstance(output, bool):
        return False
    sides = sorted([a, b, c])
    # Check if the Pythagorean theorem holds (with tolerance for floats)
    is_right = abs(sides[0]**2 + sides[1]**2 - sides[2]**2) < 1e-6
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
