
def precondition(input):
    l = input[0]
    # Check that l is a list
    if not isinstance(l, list):
        return False
    # Check that the list is non-empty
    if len(l) == 0:
        return False
    # Check that all elements are comparable (numbers)
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    # Check that output is in the list
    if output not in l:
        return False
    # Check that output is greater than or equal to all elements
    for item in l:
        if output < item:
            return False
    return True

def _impl(l: list):
    """Return maximum element in the list.
    3
    123"""
    return max(l)

def max_element(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
