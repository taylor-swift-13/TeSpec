
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 3:
        return False
    a, b, c = inputs
    if not all(isinstance(x, (int, float)) for x in (a, b, c)):
        return False
    return True

def postcondition(inputs: tuple, output) -> bool:
    a, b, c = inputs
    is_valid = a > 0 and b > 0 and c > 0 and a + b > c and a + c > b and b + c > a
    if is_valid:
        return isinstance(output, (int, float)) and output >= 0
    else:
        return output == -1

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
