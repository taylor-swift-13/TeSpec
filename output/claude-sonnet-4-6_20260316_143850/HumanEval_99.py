
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    value = input[0]
    if not isinstance(value, str):
        return False
    if len(value) == 0:
        return False
    try:
        float(value)
        return True
    except (ValueError, TypeError):
        return False


def postcondition(input, output) -> bool:
    if not isinstance(output, int):
        return False
    value = input[0]
    try:
        num = float(value)
    except (ValueError, TypeError):
        return False
    import math
    # Check output is one of the two nearest integers
    floor_val = math.floor(num)
    ceil_val = math.ceil(num)
    if output not in (floor_val, ceil_val):
        return False
    # Check rounding away from zero for equidistant case
    frac = abs(num - math.floor(num))
    if abs(frac - 0.5) < 1e-9:
        # equidistant: should round away from zero
        if num > 0:
            return output == ceil_val
        else:
            return output == floor_val
    else:
        # standard rounding: closest integer
        if abs(num - floor_val) < abs(num - ceil_val):
            return output == floor_val
        else:
            return output == ceil_val

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
