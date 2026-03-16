
def precondition(input):
    l, = input
    return isinstance(l, list)

def postcondition(input, output):
    l, = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, (int, float)) for x in output):
        return False
    if not all(x > 0 for x in output):
        return False
    if not all(x in l for x in output):
        return False
    return True

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
