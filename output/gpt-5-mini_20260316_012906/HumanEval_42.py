
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    import math
    for a, b in zip(l, output):
        if not isinstance(a, (int, float)):
            return False
        if not isinstance(b, (int, float)):
            return False
        # use isclose for floats to tolerate minor rounding
        if isinstance(a, float) or isinstance(b, float):
            if not math.isclose(b, a + 1):
                return False
        else:
            if b != a + 1:
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
