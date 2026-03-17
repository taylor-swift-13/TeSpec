
def precondition(args) -> bool:
    lst, = args
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, int):
            return False
        if isinstance(item, bool):
            return False
    return True


def postcondition(args, output) -> bool:
    lst, = args
    if len(lst) < 2:
        return output is None
    unique_elements = set(lst)
    if len(unique_elements) < 2:
        return output is None
    sorted_unique = sorted(unique_elements)
    second_smallest = sorted_unique[1]
    return output == second_smallest

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
