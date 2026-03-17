
def precondition(input):
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, list):
        return False
    l = input[0]
    # Output should contain only unique elements
    if len(output) != len(set(output)):
        return False
    # Output should be sorted
    if output != sorted(output):
        return False
    # Every element in output should be in input
    for elem in output:
        if elem not in l:
            return False
    # Every element in input should be in output
    for elem in l:
        if elem not in output:
            return False
    return True

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
