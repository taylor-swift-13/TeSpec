
def precondition(input):
    lst = input[0]
    return isinstance(lst, list) and all(isinstance(x, int) for x in lst)

def postcondition(input, output):
    lst = input[0]
    unique_elements = sorted(list(set(lst)))
    
    if len(unique_elements) < 2:
        return output is None
    else:
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
