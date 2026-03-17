
def precondition(args):
    if len(args) != 1:
        return False
    value = args[0]
    if not isinstance(value, str):
        return False
    # Check if the string represents a valid number
    s = value.strip()
    if len(s) == 0:
        return False
    try:
        float(s)
        return True
    except ValueError:
        return False


def postcondition(args, output):
    if not isinstance(output, int):
        return False
    value = args[0]
    s = value.strip()
    num = float(s)
    
    # Check that output is an integer closest to num
    # with ties rounded away from zero
    
    import math
    
    floor_val = math.floor(num)
    ceil_val = math.ceil(num)
    
    # If num is already an integer
    if floor_val == ceil_val:
        return output == floor_val
    
    dist_to_floor = num - floor_val
    dist_to_ceil = ceil_val - num
    
    # Check if equidistant (0.5 case)
    if abs(dist_to_floor - dist_to_ceil) < 1e-9:
        # Round away from zero
        if num > 0:
            expected = ceil_val
        else:
            expected = floor_val
    elif dist_to_floor < dist_to_ceil:
        expected = floor_val
    else:
        expected = ceil_val
    
    return output == int(expected)

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
