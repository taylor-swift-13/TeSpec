
def precondition(input):
    l1, l2 = input
    return isinstance(l1, list) and isinstance(l2, list)

def postcondition(input, output):
    l1, l2 = input
    if not isinstance(output, list):
        return False
    common = set(l1) & set(l2)
    if set(output) != common:
        return False
    if output != sorted(list(set(output))):
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
