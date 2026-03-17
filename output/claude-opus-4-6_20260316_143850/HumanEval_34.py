
def precondition(input):
    l, = input
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output):
    l, = input
    if not isinstance(output, list):
        return False
    # Output should contain exactly the unique elements of l
    if set(output) != set(l):
        return False
    # Output should have no duplicates
    if len(output) != len(set(output)):
        return False
    # Output should be sorted
    for i in range(len(output) - 1):
        if output[i] >= output[i + 1]:
            return False
    return True

def _impl(l: list):
    """Return sorted unique elements in a list
    [0, 2, 3, 5, 9, 123]"""
    return sorted(set(l))

def unique(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
