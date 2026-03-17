
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    l1, l2 = input
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    return True


def postcondition(input, output) -> bool:
    l1, l2 = input
    if not isinstance(output, list):
        return False
    # Output must be sorted
    if output != sorted(output):
        return False
    # Output must be unique
    if len(output) != len(set(output)):
        return False
    # Every element in output must be in both l1 and l2
    for elem in output:
        if elem not in l1 or elem not in l2:
            return False
    # Every common element must be in output
    common = set(l1) & set(l2)
    for elem in common:
        if elem not in output:
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
