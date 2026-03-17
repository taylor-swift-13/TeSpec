
def precondition(input) -> bool:
    try:
        l = input[0]
        if not isinstance(l, list):
            return False
        for item in l:
            if not isinstance(item, (int, float)):
                return False
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        l = input[0]
        if not isinstance(output, list):
            return False
        for item in output:
            if not isinstance(item, (int, float)):
                return False
            if item <= 0:
                return False
        for item in output:
            if item not in l:
                return False
        for item in l:
            if item > 0:
                if item not in output:
                    return False
        return True
    except Exception:
        return False

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
