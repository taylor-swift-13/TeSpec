
def precondition(input):
    # Check that we have exactly 3 arguments
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    # All three arguments should be numbers (int or float)
    for arg in input:
        if not isinstance(arg, (int, float)):
            return False
    return True

def postcondition(input, output):
    x, y, z = input
    # Output must be a boolean
    if not isinstance(output, bool):
        return False
    
    # Check if all are integers
    all_integers = all(isinstance(n, int) and not isinstance(n, bool) for n in [x, y, z])
    
    # Check if one number equals sum of other two
    one_is_sum = (x == y + z) or (y == x + z) or (z == x + y)
    
    # Expected result: True only if all are integers AND one equals sum of other two
    expected = all_integers and one_is_sum
    
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
