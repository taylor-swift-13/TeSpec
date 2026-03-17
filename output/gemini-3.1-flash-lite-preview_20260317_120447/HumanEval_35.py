
def precondition(input):
    l = input[0]
    return isinstance(l, list) and len(l) > 0

def postcondition(input, output):
    l = input[0]
    return output in l and all(output >= x for x in l)

def _impl(l: list):
    """Return maximum element in the list.
    3
    123"""
    return max(l)

def max_element(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
