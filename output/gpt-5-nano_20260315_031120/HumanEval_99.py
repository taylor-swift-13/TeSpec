
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if s.strip() == "":
        return False
    try:
        val = float(s)
    except Exception:
        return False
    import math
    if not math.isfinite(val):
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    s = input[0]
    val = float(s)
    import math
    if not math.isfinite(val):
        return False
    if not isinstance(output, int):
        return False
    n = val
    lower = math.floor(n)
    upper = math.ceil(n)
    if n == lower:
        expected = int(n)
    else:
        dlow = n - lower
        dhigh = upper - n
        if abs(dlow - dhigh) <= 1e-12:
            if n > 0:
                expected = int(upper)
            elif n < 0:
                expected = int(lower)
            else:
                expected = 0
        elif dlow < dhigh:
            expected = int(lower)
        else:
            expected = int(upper)
    return output == expected

def _impl(value):
    """Create a function that takes a value (string) representing a number
    and returns the closest integer to it. If the number is equidistant
    from two integers, round it away from zero.

    Examples
    10
    15

    Note:
    Rounding away from zero means that if the given number is equidistant
    from two integers, the one you should return is the one that is the
    farthest from zero. For example closest_integer("14.5") should
    return 15 and closest_integer("-14.5") should return -15."""
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
