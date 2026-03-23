import math

def problem_99_pre(r):
    return True

def problem_99_spec(r, res):
    r = float(r)
    res = int(res)
    
    floor_r = math.floor(r)
    ceil_r = math.ceil(r)
    
    dist_floor = r - floor_r
    dist_ceil = ceil_r - r
    
    if dist_floor == dist_ceil:
        if r >= 0:
            expected = ceil_r
        else:
            expected = floor_r
    elif dist_floor < dist_ceil:
        expected = floor_r
    else:
        expected = ceil_r
        
    return res == expected

def _impl(value):
    def rounding(val):
        if abs(val - int(val)) != 0.5:
            return round(val)
        if val > 0:
            return int(val) + 1
        else:
            return int(val) - 1
    return rounding(float(value))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_99_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_99_spec(*input, output))

def closest_integer(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
