
def precondition(input):
    try:
        (value,) = input
        if not isinstance(value, str):
            return False
        value_stripped = value.strip()
        if len(value_stripped) == 0:
            return False
        float(value_stripped)
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        (value,) = input
        if not isinstance(output, int):
            return False
        num = float(value.strip())
        # Check rounding away from zero for .5 cases
        import math
        fractional = num - math.floor(num)
        # Check if equidistant (fractional part is exactly 0.5)
        if abs(fractional - 0.5) < 1e-9:
            # Round away from zero
            if num >= 0:
                expected = math.ceil(num)
            else:
                expected = math.floor(num)
        else:
            # Standard rounding to nearest
            expected = round(num)
        return output == expected
    except Exception:
        return False

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
