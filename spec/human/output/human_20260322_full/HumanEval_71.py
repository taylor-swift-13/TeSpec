import math

def is_valid_triangle(a, b, c):
    return a > 0 and b > 0 and c > 0 and a + b > c and a + c > b and b + c > a

def heron_area(a, b, c):
    s = (a + b + c) / 2.0
    # The product inside sqrt is guaranteed to be positive for valid triangles
    return math.sqrt(s * (s - a) * (s - b) * (s - c))

def is_rounded_to_2_decimals(rounded_val, original_val):
    # Check if rounded_val can be represented as z / 100 for some integer z
    z = round(rounded_val * 100)
    if abs(z / 100.0 - rounded_val) > 1e-7:
        return False
    # Check if original_val is within the rounding bounds
    return (rounded_val - 0.005 <= original_val) and (original_val < rounded_val + 0.005)

def problem_71_pre(a, b, c):
    return True

def problem_71_spec(a, b, c, ret):
    if is_valid_triangle(a, b, c):
        return is_rounded_to_2_decimals(ret, heron_area(a, b, c))
    else:
        return ret == -1

def _impl(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a: return -1
    p = (a + b + c) / 2
    return round((p * (p - a) * (p - b) * (p - c)) ** 0.5, 2)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_71_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_71_spec(*input, output))

def triangle_area(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
