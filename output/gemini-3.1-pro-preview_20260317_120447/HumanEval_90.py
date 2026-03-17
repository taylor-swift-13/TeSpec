
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    lst = inp[0]
    return isinstance(lst, list) and all(isinstance(x, int) for x in lst)

def postcondition(inp, out):
    lst = inp[0]
    unique_lst = sorted(set(lst))
    if len(unique_lst) < 2:
        return out is None
    return out == unique_lst[1]

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
