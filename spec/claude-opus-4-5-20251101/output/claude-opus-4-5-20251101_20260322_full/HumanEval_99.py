import math

def truncate(r: float) -> int:
    # In Coq, `up r` is the integer z such that z - 1 <= r < z.
    # Therefore, `up r - 1` is exactly the mathematical floor of r.
    # Z.abs_nat takes the absolute value, and S adds 1.
    if r < 0:
        return abs(math.floor(r)) + 1
    else:
        return abs(math.floor(r))

def is_equidistant(r: float) -> bool:
    return abs(r - truncate(r)) == 0.5

def round_away_from_zero(r: float) -> int:
    if r < 0:
        return truncate(r) - 1
    else:
        return truncate(r) + 1

def standard_round(r: float) -> int:
    if (r - truncate(r)) <= 0.5:
        return truncate(r)
    elif r < 0:
        return truncate(r) - 1
    else:
        return truncate(r) + 1

def closest_integer_spec(value: float, result: int) -> bool:
    if is_equidistant(value):
        return result == round_away_from_zero(value)
    else:
        return result == standard_round(value)

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
