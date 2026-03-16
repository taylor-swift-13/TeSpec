
def precondition(input):
    x, y, z = input
    return isinstance(x, int) and isinstance(y, int) and isinstance(z, int)

def postcondition(input, output):
    x, y, z = input
    if not isinstance(output, bool):
        return False
    if output:
        return (x == y + z) or (y == x + z) or (z == x + y)
    else:
        return not ((x == y + z) or (y == x + z) or (z == x + y))

def _impl(x, y, z):
    """Create a function that takes 3 numbers.
    Returns true if one of the numbers is equal to the sum of the other two, and all numbers are integers.
    Returns false in any other cases.

    Examples
    any_int(5, 2, 7) ➞ True

    any_int(3, 2, 2) ➞ False

    any_int(3, -2, 1) ➞ True

    any_int(3.6, -2.2, 2) ➞ False"""
    if type(x) != int or type(y) != int or type(z) != int: return False
    return x == y + z or y == x + z or z == y + x

def any_int(x, y, z):
    _input = (x, y, z)
    assert precondition(_input)
    _output = _impl(x, y, z)
    assert postcondition(_input, _output)
    return _output
