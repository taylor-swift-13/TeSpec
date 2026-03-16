
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False

    # build unique elements of l in first-seen order
    seen = []
    for item in l:
        if item not in seen:
            seen.append(item)

    # attempt to verify that output is the sorted version of seen
    try:
        expected = sorted(seen)
        if len(output) != len(expected):
            return False
        for a, b in zip(output, expected):
            if a != b:
                return False
        return True
    except Exception:
        # elements not sortable; verify output is a permutation of seen
        if len(output) != len(seen):
            return False
        tmp = seen.copy()
        for item in output:
            if item in tmp:
                tmp.remove(item)
            else:
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
