
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    l = input[0]
    try:
        max_val = max(l)
    except Exception:
        return False
    return output == max_val

def _impl(l: list):
    """
    Return maximum element in the list.
    3
    123
    """
    return max(l)

def max_element(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
