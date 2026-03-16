
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    l, t = input
    if not isinstance(l, list):
        return False
    if not isinstance(t, int):
        return False
    for x in l:
        try:
            r = x < t
            _ = bool(r)
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    l, t = input
    expected = True
    for x in l:
        if not bool(x < t):
            expected = False
            break
    return isinstance(output, bool) and output == expected

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
