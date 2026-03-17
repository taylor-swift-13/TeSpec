
def precondition(input) -> bool:
    try:
        l = input[0]
        if not isinstance(l, list):
            return False
        if len(l) == 0:
            return False
        for item in l:
            if not isinstance(item, (int, float)):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        l = input[0]
        if not isinstance(output, (int, float)):
            return False
        if output not in l:
            return False
        for item in l:
            if item > output:
                return False
        return True
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
