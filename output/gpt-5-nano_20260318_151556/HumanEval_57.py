
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False

    n = len(l)
    if n <= 1:
        expected = True
    else:
        non_decreasing = True
        non_increasing = True
        for i in range(1, n):
            a = l[i - 1]
            b = l[i]
            try:
                if b < a:
                    non_decreasing = False
                if b > a:
                    non_increasing = False
            except TypeError:
                return False
        expected = non_decreasing or non_increasing

    return output == expected

def _impl(l: list):
    """
    Return True is list elements are monotonically increasing or decreasing.
    True
    False
    True
    """
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
