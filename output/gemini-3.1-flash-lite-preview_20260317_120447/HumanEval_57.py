
def precondition(input):
    l = input[0]
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    l = input[0]
    if len(l) <= 1:
        return output is True
    
    increasing = all(l[i] <= l[i+1] for i in range(len(l) - 1))
    decreasing = all(l[i] >= l[i+1] for i in range(len(l) - 1))
    
    return output == (increasing or decreasing)

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
