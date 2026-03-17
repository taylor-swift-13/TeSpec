
def precondition(input):
    try:
        value = float(input[0])
        return True
    except (ValueError, TypeError):
        return False

def postcondition(input, output):
    val = float(input[0])
    res = int(output)
    
    if abs(val - res) > 0.5:
        return False
    
    if abs(val - res) == 0.5:
        if val > 0:
            return res == int(val) + 1
        else:
            return res == int(val) - 1
            
    return res == round(val) if abs(val % 1) != 0.5 else True

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
