
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    value = input[0]
    if not isinstance(value, str):
        return False
    try:
        from decimal import Decimal, InvalidOperation
        d = Decimal(value)
    except Exception:
        return False
    # Reject NaN and infinities
    try:
        if not d.is_finite():
            return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    # Ensure output is a plain int (not bool or numpy int)
    if type(output) is not int:
        return False
    value = input[0]
    try:
        from decimal import Decimal
        d = Decimal(value)
    except Exception:
        return False
    # Compute expected result: nearest integer, ties away from zero
    sign = 1 if d >= 0 else -1
    ad = abs(d)
    try:
        integer_part = int(ad)
    except Exception:
        return False
    frac = ad - Decimal(integer_part)
    half = Decimal('0.5')
    if frac < half:
        expected = sign * integer_part
    else:
        expected = sign * (integer_part + 1)
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
