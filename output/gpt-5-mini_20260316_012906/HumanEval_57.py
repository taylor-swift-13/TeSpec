
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    # Ensure adjacent elements are comparable with <= and >= to avoid runtime errors
    for i in range(len(l) - 1):
        a = l[i]
        b = l[i + 1]
        try:
            _ = a <= b
            _ = a >= b
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, bool):
        return False
    try:
        nondecreasing = True
        nonincreasing = True
        for i in range(len(l) - 1):
            a = l[i]
            b = l[i + 1]
            if not (a <= b):
                nondecreasing = False
            if not (a >= b):
                nonincreasing = False
            if not nondecreasing and not nonincreasing:
                break
    except Exception:
        return False
    return output == (nondecreasing or nonincreasing)

def _impl(l: list):
    """Return True is list elements are monotonically increasing or decreasing.
    True
    False
    True"""
    inc, dec = True, True
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]: inc = False
        if l[i] < l[i + 1]: dec = False
    return inc or dec

def monotonic(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
