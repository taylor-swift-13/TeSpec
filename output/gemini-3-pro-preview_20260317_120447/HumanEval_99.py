
def precondition(args):
    if not (isinstance(args, tuple) and len(args) == 1):
        return False
    value = args[0]
    if not isinstance(value, str):
        return False
    try:
        float(value)
        return True
    except ValueError:
        return False

def postcondition(args, output):
    if not isinstance(output, int):
        return False
    val_float = float(args[0])
    diff = abs(val_float - output)
    if diff > 0.5:
        return False
    if diff == 0.5:
        if abs(output) < abs(val_float):
            return False
    else:
        if diff > abs(val_float - round(val_float)):
            # This handles cases where another integer might be closer, 
            # though diff <= 0.5 usually covers it.
            return False
    return True

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
