
def precondition(args):
    if len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(args, output):
    l = args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    for orig, new in zip(l, output):
        if new != orig + 1:
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
