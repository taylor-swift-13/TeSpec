
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
    if not precondition(input):
        return True
    l = input[0]
    n = len(l)
    if n <= 1:
        expected = True
    else:
        try:
            inc = True
            for i in range(n - 1):
                if l[i] > l[i + 1]:
                    inc = False
                    break
            dec = True
            for i in range(n - 1):
                if l[i] < l[i + 1]:
                    dec = False
                    break
            expected = inc or dec
        except Exception:
            expected = False
    return output == expected

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
