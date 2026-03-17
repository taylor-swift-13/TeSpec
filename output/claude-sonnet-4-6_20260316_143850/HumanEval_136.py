
def precondition(input):
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    for item in lst:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    lst = input[0]
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    a, b = output
    negatives = [x for x in lst if x < 0]
    positives = [x for x in lst if x > 0]
    if negatives:
        if a != max(negatives):
            return False
    else:
        if a is not None:
            return False
    if positives:
        if b != min(positives):
            return False
    else:
        if b is not None:
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
