
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    v = input[0]
    if not isinstance(v, str):
        return False
    s = v.strip()
    if s == "":
        return False
    try:
        from decimal import Decimal
        d = Decimal(s)
    except Exception:
        return False
    if not d.is_finite():
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    if type(output) is not int:
        return False
    from decimal import Decimal, ROUND_HALF_UP
    s = input[0].strip()
    try:
        d = Decimal(s)
    except Exception:
        return True
    if not d.is_finite():
        return True
    expected = int(d.to_integral_value(rounding=ROUND_HALF_UP))
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
