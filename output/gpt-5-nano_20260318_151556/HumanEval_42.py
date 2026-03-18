
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    for a, b in zip(l, output):
        try:
            if b != a + 1:
                return False
        except Exception:
            return False
    return True

def _impl(l: list):
    """
    Return list with elements incremented by 1.
    [2, 3, 4]
    [6, 4, 6, 3, 4, 4, 10, 1, 124]
    """
    return [x + 1 for x in l]

def incr_list(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
