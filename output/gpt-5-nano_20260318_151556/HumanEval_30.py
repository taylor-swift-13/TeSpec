
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
        return False
    if not isinstance(output, list):
        return False
    for x in output:
        if not isinstance(x, (int, float)):
            return False
        if x <= 0:
            return False
    expected = [x for x in l if isinstance(x, (int, float)) and x > 0]
    return output == expected

def _impl(l: list):
    """
    Return only positive numbers in the list.
    [2, 5, 6]
    [5, 3, 2, 3, 9, 123, 1]
    """
    return list(filter(lambda x: x > 0, l))

def get_positive(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
