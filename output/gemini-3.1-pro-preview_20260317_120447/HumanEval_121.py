
def precondition(args):
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list) or len(lst) == 0:
        return False
    return all(isinstance(x, int) and not isinstance(x, bool) for x in lst)

def postcondition(args, output):
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    expected_sum = sum(x for i, x in enumerate(lst) if i % 2 == 0 and x % 2 != 0)
    return output == expected_sum

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
