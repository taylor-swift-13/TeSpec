
import numbers

def precondition(input):
    if not isinstance(input, (list, tuple)):
        return False
    if len(input) != 3:
        return False
    for v in input:
        if not isinstance(v, numbers.Real):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    x, y, z = input
    def is_int_type(v):
        return isinstance(v, int) and not isinstance(v, bool)
    all_ints = is_int_type(x) and is_int_type(y) and is_int_type(z)
    sum_check = (x == y + z) or (y == x + z) or (z == x + y)
    expected = bool(all_ints and sum_check)
    if not isinstance(output, bool):
        return False
    return output == expected

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
