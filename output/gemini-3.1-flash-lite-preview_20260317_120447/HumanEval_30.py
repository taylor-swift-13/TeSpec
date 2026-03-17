
def precondition(input):
    l = input[0]
    return isinstance(l, list) and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    return isinstance(output, list) and all(x > 0 for x in output) and all(x in input[0] for x in output)

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
