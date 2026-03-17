
def precondition(input):
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    return all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(output, list):
        return False
    return output == [x for x in l if x > 0]

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
