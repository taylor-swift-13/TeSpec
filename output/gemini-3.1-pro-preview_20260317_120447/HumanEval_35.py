
def precondition(inputs):
    if len(inputs) != 1:
        return False
    l = inputs[0]
    return isinstance(l, list) and len(l) > 0

def postcondition(inputs, output):
    l = inputs[0]
    try:
        return output in l and all(output >= x for x in l)
    except Exception:
        return False

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
