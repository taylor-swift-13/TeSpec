
def precondition(input) -> bool:
    if len(input) != 3:
        return False
    a, b, c = input
    if not all(isinstance(x, (int, float)) for x in (a, b, c)):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    a, b, c = input
    if all(isinstance(x, int) for x in (a, b, c)):
        expected = (a * a + b * b == c * c) or \
                   (a * a + c * c == b * b) or \
                   (b * b + c * c == a * a)
        if output != expected:
            return False
    return True

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
