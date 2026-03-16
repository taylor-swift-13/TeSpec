
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    # all elements should be integers (booleans are subclasses of int, allow them)
    for x in lst:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    # If precondition does not hold, do not attempt to verify postcondition here.
    if not precondition(input):
        return True
    lst = input[0]
    # output must be a tuple of length 2
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    a, b = output
    # a and b must be either None or ints
    if a is not None and not isinstance(a, int):
        return False
    if b is not None and not isinstance(b, int):
        return False
    # collect negative and positive integers from the list (zero is neither)
    negatives = [x for x in lst if isinstance(x, int) and x < 0]
    positives = [x for x in lst if isinstance(x, int) and x > 0]
    # a should be None exactly when there are no negatives
    if not negatives:
        if a is not None:
            return False
    else:
        # a must be the largest (maximum) among negatives
        if a is None:
            return False
        if a not in negatives:
            return False
        # check maximality: for all n in negatives, n <= a
        for n in negatives:
            if n > a:
                return False
    # b should be None exactly when there are no positives
    if not positives:
        if b is not None:
            return False
    else:
        # b must be the smallest (minimum) among positives
        if b is None:
            return False
        if b not in positives:
            return False
        for p in positives:
            if p < b:
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
