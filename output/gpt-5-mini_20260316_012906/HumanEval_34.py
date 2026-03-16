
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    try:
        # check that elements can be sorted (will raise TypeError if not comparable)
        sorted(l)
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, list):
        return False
    l = input[0]
    # build list of distinct elements from l preserving first occurrence (use equality)
    try:
        uniq = []
        for x in l:
            if not any(x == y for y in uniq):
                uniq.append(x)
        # sorted unique elements should match output
        sorted_uniq = sorted(uniq)
    except Exception:
        return False
    return output == sorted_uniq

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
