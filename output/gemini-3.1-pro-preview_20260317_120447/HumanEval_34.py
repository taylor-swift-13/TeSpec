
def precondition(inputs):
    if len(inputs) != 1:
        return False
    if not isinstance(inputs[0], list):
        return False
    return True

def postcondition(inputs, output):
    if not isinstance(output, list):
        return False
    l = inputs[0]
    for i in range(len(output) - 1):
        if not (output[i] < output[i + 1]):
            return False
    for x in output:
        if x not in l:
            return False
    for x in l:
        if x not in output:
            return False
    return True

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
