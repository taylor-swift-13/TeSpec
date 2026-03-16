
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    l, t = input
    if not isinstance(l, list):
        return False
    if not isinstance(t, int):
        return False
    return True

def postcondition(input, output) -> bool:
    l, t = input
    try:
        expected = all(x < t for x in l)
    except Exception:
        return False
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
