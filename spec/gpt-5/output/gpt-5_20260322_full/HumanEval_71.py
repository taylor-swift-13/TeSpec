import math

def triangle_area_spec(a, b, c, area):
    if a + b <= c or a + c <= b or b + c <= a:
        return area == -1
    else:
        p = (a + b + c) / 2.0
        val = p * (p - a) * (p - b) * (p - c)
        # Use max(0.0, val) to avoid math domain errors from minor floating-point inaccuracies
        x = math.sqrt(max(0.0, val))
        
        # Python's built-in round() implements round-half-to-even, 
        # which perfectly matches the Coq tie-breaking specification (Zeven k).
        k = round(x * 100.0)
        
        expected_area = k / 100.0
        return area == expected_area

def _impl(a, b, c):
    if a + b <= c or a + c <= b or b + c <= a: return -1
    p = (a + b + c) / 2
    return round((p * (p - a) * (p - b) * (p - c)) ** 0.5, 2)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(triangle_area_spec(*input, output))

def triangle_area(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
