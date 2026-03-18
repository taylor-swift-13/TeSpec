
def precondition(input):
    # Expect a tuple of three numeric arguments (ints or floats), excluding booleans
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    for n in input:
        if isinstance(n, bool) or not isinstance(n, (int, float)):
            return False
    return True

def postcondition(input, output):
    # Validate input format
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    a, b, c = input
    # Output must be boolean
    if not isinstance(output, bool):
        return False
    # All inputs must be integers (not bool)
    def is_int_num(x):
        return isinstance(x, int) and not isinstance(x, bool)
    if not (is_int_num(a) and is_int_num(b) and is_int_num(c)):
        return output is False
    # Condition: one number equals sum of the other two
    cond = (a == b + c) or (b == a + c) or (c == a + b)
    return output == cond

def _impl(x, y, z):
    """
    Create a function that takes 3 numbers.
    Returns true if one of the numbers is equal to the sum of the other two, and all numbers are integers.
    Returns false in any other cases.

    Examples
    any_int(5, 2, 7) ➞ True

    any_int(3, 2, 2) ➞ False

    any_int(3, -2, 1) ➞ True

    any_int(3.6, -2.2, 2) ➞ False
    """
    if type(x) != int or type(y) != int or type(z) != int: return False
    return x == y + z or y == x + z or z == y + x

def any_int(x, y, z):
    _input = (x, y, z)
    assert precondition(_input)
    _output = _impl(x, y, z)
    assert postcondition(_input, _output)
    return _output
