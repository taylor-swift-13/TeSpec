
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    if output not in l:
        return False
    for item in l:
        if item > output:
            return False
    return True

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
