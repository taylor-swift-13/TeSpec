
def precondition(input_args):
    l, t = input_args
    if not isinstance(l, list):
        return False
    if not isinstance(t, (int, float)):
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input_args, output):
    l, t = input_args
    expected = all(x < t for x in l)
    return output == expected

def _impl(l: list, t: int):
    """Return True if all numbers in the list l are below threshold t.
    True
    False"""
    return all(x < t for x in l)

def below_threshold(l: list, t: int):
    _input = (l, t)
    assert precondition(_input)
    _output = _impl(l, t)
    assert postcondition(_input, _output)
    return _output
