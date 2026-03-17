
def precondition(input):
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    if len(lst) == 0:
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
        if isinstance(item, bool):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, int):
        return False
    if isinstance(output, bool):
        return False
    lst = input[0]
    expected = sum(lst[i] for i in range(0, len(lst), 2) if lst[i] % 2 != 0)
    return output == expected

def _impl(lst):
    """Given a non-empty list of integers, return the sum of all of the odd elements that are in even positions.


    Examples
    solution([5, 8, 7, 1]) ==> 12
    solution([3, 3, 3, 3, 3]) ==> 9
    solution([30, 13, 24, 321]) ==>0"""
    return sum(lst[i] for i in range(len(lst)) if i % 2 == 0 and lst[i] % 2 == 1)

def solution(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
