
def precondition(args):
    if len(args) != 2:
        return False
    l, t = args
    if not isinstance(l, list):
        return False
    if not isinstance(t, (int, float)):
        return False
    for item in l:
        if not isinstance(item, (int, float)):
            return False
    return True


def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    l, t = args
    if not l:
        return output == True
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
