
def precondition(input):
    value, = input
    if not isinstance(value, str):
        return False
    try:
        float(value)
        return True
    except ValueError:
        return False

def postcondition(input, output):
    value, = input
    if not isinstance(output, int):
        return False
    try:
        num = float(value)
        if num.is_integer():
            return output == int(num)
        floor_val = int(num) if num >= 0 else int(num) - 1
        ceil_val = floor_val + 1
        if abs(num - floor_val) == abs(num - ceil_val):
            return output == (ceil_val if num >= 0 else floor_val)
        return output == (floor_val if abs(num - floor_val) < abs(num - ceil_val) else ceil_val)
    except (ValueError, TypeError):
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
