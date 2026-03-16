
def precondition(input) -> bool:
    try:
        l1, l2 = input
    except Exception:
        return False
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    return True

def postcondition(input, output) -> bool:
    l1, l2 = input
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    if not isinstance(output, list):
        return False

    seen = []
    for x in l1:
        if x in l2 and x not in seen:
            seen.append(x)

    try:
        expected = sorted(seen)
    except Exception:
        return False

    return output == expected

def _impl(l1: list, l2: list):
    """Return sorted unique common elements for two lists.
    [1, 5, 653]
    [2, 3]"""
    return sorted(list(set(l1).intersection(set(l2))))

def common(l1: list, l2: list):
    _input = (l1, l2)
    assert precondition(_input)
    _output = _impl(l1, l2)
    assert postcondition(_input, _output)
    return _output
