
def precondition(args):
    l1, l2 = args
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    for elem in l1 + l2:
        if not isinstance(elem, int):
            return False
    return True

def postcondition(args, result):
    l1, l2 = args
    if not isinstance(result, list):
        return False
    if not all(isinstance(x, int) for x in result):
        return False
    if result != sorted(result):
        return False
    if len(result) != len(set(result)):
        return False
    for elem in result:
        if elem not in l1 or elem not in l2:
            return False
    for elem in l1:
        if elem in l2 and elem not in result:
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
