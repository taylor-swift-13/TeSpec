
def precondition(args):
    l, t = args
    if not isinstance(l, list):
        return False
    if not isinstance(t, (int, float)):
        return False
    return all(isinstance(x, (int, float)) for x in l)

def postcondition(args, output):
    l, t = args
    if not isinstance(output, bool):
        return False
    if output:
        return all(x < t for x in l)
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
