
def precondition(input):
    l, = input
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    l, = input
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    for i, (orig, new) in enumerate(zip(l, output)):
        if not isinstance(new, (int, float)):
            return False
        if not (new == orig + 1):
            return False
    return True

def _impl(l: list):
    """Return list with elements incremented by 1.
    [2, 3, 4]
    [6, 4, 6, 3, 4, 4, 10, 1, 124]"""
    return [x + 1 for x in l]

def incr_list(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
