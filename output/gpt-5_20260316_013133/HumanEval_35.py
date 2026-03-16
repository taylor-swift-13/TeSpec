
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    try:
        max(l)
    except Exception:
        return False
    return True

def postcondition(input, output):
    l = input[0]
    def is_nan(x):
        try:
            return x != x
        except Exception:
            return False
    found_match = False
    for e in l:
        if e is output:
            found_match = True
            break
        try:
            if e == output:
                found_match = True
                break
        except Exception:
            pass
        if is_nan(e) and is_nan(output):
            found_match = True
            break
    if not found_match:
        return False
    for e in l:
        try:
            if e > output:
                return False
        except Exception:
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
