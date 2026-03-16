
def precondition(input):
    l, = input
    return isinstance(l, list) and len(l) > 0

def postcondition(input, output):
    l, = input
    if not precondition(input):
        return False
    return all(output >= x for x in l) and output in l

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
