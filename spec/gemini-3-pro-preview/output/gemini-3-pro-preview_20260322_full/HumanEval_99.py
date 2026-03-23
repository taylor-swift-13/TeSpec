def closest_integer_spec(val, result):
    dist = abs(val - result)
    return (dist < 0.5) or (dist == 0.5 and abs(result) > abs(val))

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
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(closest_integer_spec(*input, output))

def closest_integer(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
