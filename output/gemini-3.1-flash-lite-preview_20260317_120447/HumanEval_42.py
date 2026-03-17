
def precondition(input):
    l = input[0]
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    l = input[0]
    return isinstance(output, list) and len(output) == len(l) and all(output[i] == l[i] + 1 for i in range(len(l)))

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
