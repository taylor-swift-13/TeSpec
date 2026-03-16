
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    import numbers
    for x in l:
        # disallow booleans (subclass of int)
        if isinstance(x, bool):
            return False
        if not isinstance(x, numbers.Real):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    l = input[0]
    if not isinstance(output, list):
        return False
    import numbers
    # all items in output must be real numbers (not bool) and strictly positive
    for y in output:
        if isinstance(y, bool):
            return False
        if not isinstance(y, numbers.Real):
            return False
        try:
            if not (y > 0):
                return False
        except Exception:
            return False
    # expected = all positive real numbers from input list in order
    expected = [x for x in l if (not isinstance(x, bool) and isinstance(x, numbers.Real) and (x > 0))]
    return output == expected

def _impl(l: list):
    """Return only positive numbers in the list.
    [2, 5, 6]
    [5, 3, 2, 3, 9, 123, 1]"""
    return list(filter(lambda x: x > 0, l))

def get_positive(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
