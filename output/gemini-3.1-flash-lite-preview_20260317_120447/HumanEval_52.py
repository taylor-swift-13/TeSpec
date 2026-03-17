
def precondition(input):
    l, t = input
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l) and isinstance(t, (int, float))

def postcondition(input, output):
    l, t = input
    if output is True:
        return all(x < t for x in l)
    else:
        return any(x >= t for x in l)

def _impl(l: list, t: int):
    """Return True if all numbers in the list l are below threshold t.
    True
    False"""
    return all(x < t for x in l)

def below_threshold(l: list, t: int):
    _input = (l, t)
    assert precondition(_input)
    _output = _impl(l, t)
    assert postcondition(_input, _output)
    return _output
