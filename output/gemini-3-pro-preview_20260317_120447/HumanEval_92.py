
def precondition(input_args):
    return len(input_args) == 3

def postcondition(input_args, output):
    if not isinstance(output, bool):
        return False
    x, y, z = input_args
    all_integers = isinstance(x, int) and isinstance(y, int) and isinstance(z, int)
    if not all_integers:
        return output is False
    sum_condition = (x + y == z) or (x + z == y) or (y + z == x)
    return output == sum_condition

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
