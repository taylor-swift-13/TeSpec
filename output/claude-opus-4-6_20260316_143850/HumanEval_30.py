
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    if not all(isinstance(x, (int, float)) for x in l):
        return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, list):
        return False
    # All elements in output should be positive
    if not all(x > 0 for x in output):
        return False
    # All positive elements from input should be in output (preserving count)
    positive_in_input = [x for x in l if x > 0]
    if output != positive_in_input:
        return False
    return True

def _impl(l: list):
    """Return only positive numbers in the list.
    [2, 5, 6]
    [5, 3, 2, 3, 9, 123, 1]"""
    return list(filter(lambda x: x > 0, l))

def get_positive(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
