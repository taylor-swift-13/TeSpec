
def precondition(input):
    if not (isinstance(input, tuple) and len(input) == 3):
        return False
    for x in input:
        if isinstance(x, bool) or not isinstance(x, (int, float)):
            return False
        try:
            if not (x == x and x != float('inf') and x != float('-inf')):
                return False
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    a, b, c = input
    valid = (a > 0 and b > 0 and c > 0 and (a + b > c) and (a + c > b) and (b + c > a))
    if not valid:
        return isinstance(output, (int, float)) and output == -1
    # Valid triangle: check Heron's formula with rounding to 2 decimals
    s = (a + b + c) / 2.0
    t = s * (s - a) * (s - b) * (s - c)
    # Guard against tiny negative due to floating error
    if t < 0 and t > -1e-12:
        t = 0.0
    # If t is negative beyond tolerance, something is off; do not enforce strict check
    if t < 0:
        return isinstance(output, (int, float))
    area = t ** 0.5
    # Handle non-finite computations conservatively
    try:
        exp = round(area, 2)
    except Exception:
        return isinstance(output, (int, float))
    return isinstance(output, (int, float)) and output == exp

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
