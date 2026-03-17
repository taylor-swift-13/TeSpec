
def precondition(input):
    a, b, c = input
    return isinstance(a, (int, float)) and isinstance(b, (int, float)) and isinstance(c, (int, float)) and a > 0 and b > 0 and c > 0

def postcondition(input, output):
    a, b, c = input
    is_valid = (a + b > c) and (a + c > b) and (b + c > a)
    if not is_valid:
        return output == -1
    return isinstance(output, float)

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
