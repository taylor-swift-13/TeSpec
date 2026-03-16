
def precondition(input):
    lst, = input
    return isinstance(lst, list) and all(isinstance(x, int) for x in lst)

def postcondition(input, output):
    lst, = input
    if not precondition(input):
        return False
    if len(lst) < 2:
        return output is None
    if len(set(lst)) < 2:
        return output is None
    sorted_unique = sorted(set(lst))
    if len(sorted_unique) >= 2:
        return output == sorted_unique[1]
    return output is None

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
