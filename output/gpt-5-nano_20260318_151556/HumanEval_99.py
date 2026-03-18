
import math

def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    s = s.strip()
    if s == "":
        return False
    try:
        v = float(s)
    except ValueError:
        return False
    if not math.isfinite(v):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    s = s.strip()
    if s == "":
        return False
    try:
        v = float(s)
    except ValueError:
        return False
    if not math.isfinite(v):
        return False
    base = int(v)
    sign = 1 if v >= 0 else -1
    diff = abs(v - base)
    tol = 1e-12
    if diff < 0.5 - tol:
        expected = base
    else:
        expected = base + sign
    return expected == output

def _impl(value):
    """
    Create a function that takes a value (string) representing a number
    and returns the closest integer to it. If the number is equidistant
    from two integers, round it away from zero.

    Examples
    10
    15

    Note:
    Rounding away from zero means that if the given number is equidistant
    from two integers, the one you should return is the one that is the
    farthest from zero. For example closest_integer("14.5") should
    return 15 and closest_integer("-14.5") should return -15.
    """
    def rounding(val):
        if abs(val - int(val)) != 0.5:
            return round(val)
        if val > 0:
            return int(val) + 1
        else:
            return int(val) - 1
    return rounding(float(value))

def closest_integer(value):
    _input = (value,)
    assert precondition(_input)
    _output = _impl(value)
    assert postcondition(_input, _output)
    return _output
