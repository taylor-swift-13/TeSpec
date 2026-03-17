
def precondition(inputs: tuple) -> bool:
    return len(inputs) == 1 and isinstance(inputs[0], list)

def postcondition(inputs: tuple, output) -> bool:
    if not isinstance(output, bool):
        return False
    l = inputs[0]
    try:
        inc = all(l[i] <= l[i+1] for i in range(len(l)-1))
        dec = all(l[i] >= l[i+1] for i in range(len(l)-1))
        return output == (inc or dec)
    except Exception:
        return True

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
