
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    l1, l2 = input
    if not isinstance(l1, list) or not isinstance(l2, list):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    l1, l2 = input
    if not isinstance(output, list):
        return False
    # check output is sorted non-decreasing
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # check output elements are unique and belong to both lists
    seen = []
    for x in output:
        if x in seen:
            return False
        seen.append(x)
        if x not in l1 or x not in l2:
            return False
    # check that all common elements are present in output
    for a in l1:
        if a in l2 and a not in output:
            return False
    return True

def _impl(l1: list, l2: list):
    """
    Return sorted unique common elements for two lists.
    [1, 5, 653]
    [2, 3]
    """
    return sorted(list(set(l1).intersection(set(l2))))

def common(l1: list, l2: list):
    _input = (l1, l2)
    assert precondition(_input)
    _output = _impl(l1, l2)
    assert postcondition(_input, _output)
    return _output
