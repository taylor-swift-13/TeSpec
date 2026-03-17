
def precondition(args) -> bool:
    if len(args) != 1:
        return False
    lst = args[0]
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, int) or isinstance(item, bool):
            return False
    return True


def postcondition(args, output) -> bool:
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    
    lst = args[0]
    a, b = output
    
    negatives = [x for x in lst if x < 0]
    positives = [x for x in lst if x > 0]
    
    if len(negatives) == 0:
        if a is not None:
            return False
    else:
        if a is None:
            return False
        if a != max(negatives):
            return False
    
    if len(positives) == 0:
        if b is not None:
            return False
    else:
        if b is None:
            return False
        if b != min(positives):
            return False
    
    return True

def _impl(lst):
    """Create a function that returns a tuple (a, b), where 'a' is
    the largest of negative integers, and 'b' is the smallest
    of positive integers in a list.
    If there is no negative or positive integers, return them as None.

    Examples:
    largest_smallest_integers([2, 4, 1, 3, 5, 7]) == (None, 1)
    largest_smallest_integers([]) == (None, None)
    largest_smallest_integers([0]) == (None, None)"""
    neg = list(filter(lambda x: x < 0, lst))
    pos = list(filter(lambda x: x > 0, lst))
    return None if neg == [] else max(neg), None if pos == [] else min(pos)

def largest_smallest_integers(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
