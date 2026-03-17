
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(l):
        return False
    for i in range(len(l)):
        if output[i] != l[i] + 1:
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
