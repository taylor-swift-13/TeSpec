
def precondition(inp):
    if not isinstance(inp, tuple):
        return False
    if len(inp) < 2:
        return False
    l1, l2 = inp[0], inp[1]
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    any_str = False
    any_num = False
    for x in l1 + l2:
        try:
            hash(x)
        except TypeError:
            return False
        if isinstance(x, str):
            any_str = True
        elif isinstance(x, (int, float, bool)):
            any_num = True
        else:
            # disallow other types to avoid unpredictable ordering/comparison
            return False
    # do not allow mixing strings with numeric types (they are not comparable)
    if any_str and any_num:
        return False
    return True

def postcondition(inp, out):
    if not precondition(inp):
        return True
    l1, l2 = inp[0], inp[1]
    if not isinstance(out, list):
        return False
    try:
        s_out = set(out)
        s1 = set(l1)
        s2 = set(l2)
    except TypeError:
        return False
    # output must contain exactly the unique common elements
    if s_out != (s1 & s2):
        return False
    # output must have no duplicates
    if len(out) != len(s_out):
        return False
    # output must be sorted in non-decreasing order
    for i in range(len(out) - 1):
        if not (out[i] <= out[i + 1]):
            return False
    return True

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
