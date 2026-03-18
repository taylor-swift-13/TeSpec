
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list):
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

    try:
        expected = sorted(set(l))
    except Exception:
        uniq = []
        for x in l:
            if not any(x == y for y in uniq):
                uniq.append(x)
        try:
            expected = sorted(uniq)
        except Exception:
            return False

    return output == expected

def _impl(l: list):
    """
    Return sorted unique elements in a list
    [0, 2, 3, 5, 9, 123]
    """
    return sorted(set(l))

def unique(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
