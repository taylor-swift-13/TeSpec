
def precondition(input):
    try:
        (lst,) = input
        if not isinstance(lst, list):
            return False
        for x in lst:
            if not isinstance(x, (int, float)):
                return False
            if isinstance(x, bool):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    (lst,) = input
    unique = sorted(set(lst))
    if len(unique) < 2:
        return output is None
    else:
        return output == unique[1]

def _impl(lst):
    """You are given a list of integers.
    Write a function next_smallest() that returns the 2nd smallest element of the list.
    Return None if there is no such element.

    next_smallest([1, 2, 3, 4, 5]) == 2
    next_smallest([5, 1, 4, 3, 2]) == 2
    next_smallest([]) == None
    next_smallest([1, 1]) == None"""
    if len(lst) <= 1: return None
    sorted_list = sorted(lst)
    for x in sorted_list:
        if x != sorted_list[0]:
            return x 

def next_smallest(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
