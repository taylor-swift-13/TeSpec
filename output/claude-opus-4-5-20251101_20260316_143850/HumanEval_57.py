
def precondition(input):
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    l = input[0]
    if len(l) <= 1:
        if output != True:
            return False
    else:
        is_increasing = all(l[i] <= l[i+1] for i in range(len(l)-1))
        is_decreasing = all(l[i] >= l[i+1] for i in range(len(l)-1))
        expected = is_increasing or is_decreasing
        if output != expected:
            return False
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
