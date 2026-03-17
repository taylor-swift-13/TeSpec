
def precondition(args):
    return isinstance(args, tuple) and len(args) == 1 and isinstance(args[0], list) and all(isinstance(x, int) for x in args[0])

def postcondition(args, output):
    lst = args[0]
    unique_elements = sorted(list(set(lst)))
    if len(unique_elements) < 2:
        return output is None
    return output == unique_elements[1]

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
