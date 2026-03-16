
from numbers import Number

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    l, t = input
    if not isinstance(l, (list, tuple)):
        return False
    if not isinstance(t, Number):
        return False
    for x in l:
        if not isinstance(x, Number):
            return False
    return True

def postcondition(input, output):
    # If precondition does not hold, we do not enforce postcondition here.
    if not precondition(input):
        return True
    l, t = input
    if not isinstance(output, bool):
        return False
    try:
        expected = True
        for x in l:
            if not (x < t):
                expected = False
                break
    except Exception:
        return False
    return output == expected

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
