
def precondition(input):
    # input is a tuple of positional arguments
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    lst = input[0]
    if not isinstance(lst, list):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    lst = input[0]
    negs = [x for x in lst if type(x) is int and x < 0]
    poss = [x for x in lst if type(x) is int and x > 0]
    expected = (max(negs) if negs else None, min(poss) if poss else None)
    return isinstance(output, tuple) and len(output) == 2 and output == expected

def _impl(lst):
    """
    Create a function that returns a tuple (a, b), where 'a' is
    the largest of negative integers, and 'b' is the smallest
    of positive integers in a list.
    If there is no negative or positive integers, return them as None.

    Examples:
    largest_smallest_integers([2, 4, 1, 3, 5, 7]) == (None, 1)
    largest_smallest_integers([]) == (None, None)
    largest_smallest_integers([0]) == (None, None)
    """
    neg = list(filter(lambda x: x < 0, lst))
    pos = list(filter(lambda x: x > 0, lst))
    return None if neg == [] else max(neg), None if pos == [] else min(pos)

def largest_smallest_integers(lst):
    _input = (lst,)
    assert precondition(_input)
    _output = _impl(lst)
    assert postcondition(_input, _output)
    return _output
