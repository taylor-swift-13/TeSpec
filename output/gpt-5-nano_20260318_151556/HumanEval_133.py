
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if isinstance(x, bool):
            return False
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for x in lst:
        if isinstance(x, bool):
            return False
        if not isinstance(x, (int, float)):
            return False
    import math
    expected = sum((math.ceil(x) ** 2) for x in lst)
    return isinstance(output, int) and output == expected

def _impl(lst):
    """
    You are given a list of numbers.
    You need to return the sum of squared numbers in the given list,
    round each element in the list to the upper int(Ceiling) first.
    Examples:
    For lst = [1,2,3] the output should be 14
    For lst = [1,4,9] the output should be 98
    For lst = [1,3,5,7] the output should be 84
    For lst = [1.4,4.2,0] the output should be 29
    For lst = [-2.4,1,1] the output should be 6
    """
    import math
    return sum(map(lambda x: math.ceil(x) ** 2, lst))

def sum_squares(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
