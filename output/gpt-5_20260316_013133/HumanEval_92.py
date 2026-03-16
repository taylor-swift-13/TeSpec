
import numbers

def precondition(input):
    return isinstance(input, tuple) and len(input) == 3

def postcondition(input, output):
    if not precondition(input):
        return isinstance(output, bool)
    x, y, z = input
    def is_int_num(v):
        return isinstance(v, numbers.Integral) and not isinstance(v, bool)
    all_ints = is_int_num(x) and is_int_num(y) and is_int_num(z)
    cond = False
    if all_ints:
        try:
            cond = (x == y + z) or (y == x + z) or (z == x + y)
        except Exception:
            cond = False
    expected = all_ints and cond
    return isinstance(output, bool) and (output == expected)

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
