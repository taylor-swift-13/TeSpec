
def precondition(input) -> bool:
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], list)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    l = input[0]
    if not isinstance(output, list):
        return False

    def is_positive(x):
        if isinstance(x, bool):
            return False
        try:
            y = x > 0
        except Exception:
            return False
        try:
            return bool(y)
        except Exception:
            return False

    expected = [x for x in l if is_positive(x)]
    return output == expected

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
