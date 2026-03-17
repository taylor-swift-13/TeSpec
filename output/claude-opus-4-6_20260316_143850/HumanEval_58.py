
def precondition(input):
    l1, l2 = input
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    return True


def postcondition(input, output):
    l1, l2 = input
    if not isinstance(output, list):
        return False
    # All elements in output should be in both l1 and l2
    for elem in output:
        if elem not in l1 or elem not in l2:
            return False
    # All common elements should be in output
    for elem in l1:
        if elem in l2 and elem not in output:
            return False
    # Output should have unique elements
    if len(output) != len(set(output)):
        return False
    # Output should be sorted
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
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
