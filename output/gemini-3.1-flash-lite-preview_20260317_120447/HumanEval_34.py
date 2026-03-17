
def precondition(input):
    l = input[0]
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    return isinstance(output, list) and output == sorted(list(set(input[0])))

def _impl(l: list):
    """Return sorted unique elements in a list
    [0, 2, 3, 5, 9, 123]"""
    return sorted(set(l))

def unique(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
