
import math

def precondition(input):
    # Expect a single positional argument: a list (or tuple) of numbers (ints or floats).
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, (list, tuple)):
        return False
    for x in lst:
        if not isinstance(x, (int, float)):
            return False
        if isinstance(x, float) and not math.isfinite(x):
            return False
    return True

def postcondition(input, output):
    # Require precondition satisfied
    if not precondition(input):
        return False
    lst = input[0]
    try:
        expected = sum((math.ceil(x))**2 for x in lst)
    except Exception:
        return False
    return output == expected

def _impl(lst):
    """You are given a list of numbers.
    You need to return the sum of squared numbers in the given list,
    round each element in the list to the upper int(Ceiling) first.
    Examples:
    For lst = [1,2,3] the output should be 14
    For lst = [1,4,9] the output should be 98
    For lst = [1,3,5,7] the output should be 84
    For lst = [1.4,4.2,0] the output should be 29
    For lst = [-2.4,1,1] the output should be 6"""
    import math
    return sum(map(lambda x: math.ceil(x) ** 2, lst))

def sum_squares(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
