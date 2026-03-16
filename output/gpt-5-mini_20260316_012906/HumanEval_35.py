
def precondition(input):
    # Expect a tuple of positional args, first is the list-like container
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    # Must be iterable and have a length, and non-empty
    if not hasattr(l, "__iter__") or not hasattr(l, "__len__"):
        return False
    try:
        if len(l) == 0:
            return False
    except Exception:
        return False
    # Ensure max(l) can be computed (elements are pairwise comparable)
    try:
        _ = max(l)
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) < 1:
        return False
    l = input[0]
    # Verify max can be computed and output equals the maximum
    try:
        actual_max = max(l)
    except Exception:
        return False
    try:
        return output == actual_max
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
