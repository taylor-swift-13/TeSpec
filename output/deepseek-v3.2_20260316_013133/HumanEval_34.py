
def precondition(input):
    l, = input
    return isinstance(l, list)

def postcondition(input, output):
    l, = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, (int, float)) for x in output):
        return False
    if not all(isinstance(x, (int, float)) for x in l):
        return False
    if not (len(output) == len(set(output))):
        return False
    if not all(x in l for x in output):
        return False
    if not all(l.count(x) >= 1 for x in output):
        return False
    if not (sorted(output) == output):
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
