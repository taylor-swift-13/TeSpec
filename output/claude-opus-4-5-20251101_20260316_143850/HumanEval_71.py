
def precondition(input):
    if len(input) != 3:
        return False
    a, b, c = input
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)) or not isinstance(c, (int, float)):
        return False
    return True

def postcondition(input, output):
    a, b, c = input
    if not isinstance(output, (int, float)):
        return False
    
    # Check if triangle is valid
    is_valid_triangle = (a + b > c) and (a + c > b) and (b + c > a) and a > 0 and b > 0 and c > 0
    
    if not is_valid_triangle:
        return output == -1
    else:
        if output == -1:
            return False
        if output < 0:
            return False
        # Check output is rounded to 2 decimal places
        if round(output, 2) != output:
            return False
        # Verify area using Heron's formula
        s = (a + b + c) / 2
        area_squared = s * (s - a) * (s - b) * (s - c)
        if area_squared < 0:
            return False
        expected_area = round(area_squared ** 0.5, 2)
        return abs(output - expected_area) < 0.001

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
