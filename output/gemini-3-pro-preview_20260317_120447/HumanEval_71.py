
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 3:
        return False
    a, b, c = input_args
    return isinstance(a, (int, float)) and isinstance(b, (int, float)) and isinstance(c, (int, float))

def postcondition(input_args, output):
    a, b, c = input_args
    is_valid = (a + b > c) and (a + c > b) and (b + c > a)
    
    if not is_valid:
        return output == -1
    
    s = (a + b + c) / 2.0
    area_sq = s * (s - a) * (s - b) * (s - c)
    # area_sq could be slightly negative due to precision issues if not careful, 
    # but for valid triangles it should be >= 0.
    area = area_sq ** 0.5
    expected_output = round(area, 2)
    
    return isinstance(output, (int, float)) and abs(output - expected_output) < 1e-7

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
