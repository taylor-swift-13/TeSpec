
def precondition(args):
    if len(args) != 1:
        return False
    value = args[0]
    if not isinstance(value, str):
        return False
    try:
        f = float(value)
        import math
        if math.isinf(f) or math.isnan(f):
            return False
        return True
    except ValueError:
        return False

def postcondition(args, out):
    if not isinstance(out, int) or isinstance(out, bool):
        return False
    value = args[0]
    f_val = float(value)
    
    import math
    if f_val > 0:
        expected = math.floor(f_val + 0.5)
    elif f_val < 0:
        expected = math.ceil(f_val - 0.5)
    else:
        expected = 0
        
    return out == expected

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
