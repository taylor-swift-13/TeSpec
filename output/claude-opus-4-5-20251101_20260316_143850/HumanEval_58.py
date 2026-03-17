
def precondition(input):
    if len(input) != 2:
        return False
    l1, l2 = input
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    return True


def postcondition(input, output):
    l1, l2 = input
    if not isinstance(output, list):
        return False
    # Check that output contains only common elements
    for elem in output:
        if elem not in l1 or elem not in l2:
            return False
    # Check that output has no duplicates
    if len(output) != len(set(output)):
        return False
    # Check that output is sorted
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # Check that all common elements are included
    common = set(l1) & set(l2)
    if set(output) != common:
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
