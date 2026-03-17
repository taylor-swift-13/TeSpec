
def precondition(input) -> bool:
    try:
        l = input[0]
        if not isinstance(l, list):
            return False
        for item in l:
            _ = item < item
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        l = input[0]
        if not isinstance(output, list):
            return False
        unique_elements = set()
        for item in l:
            unique_elements.add(item)
        if len(output) != len(unique_elements):
            return False
        for item in output:
            if item not in unique_elements:
                return False
        for i in range(len(output) - 1):
            if output[i] >= output[i + 1]:
                return False
        return True
    except Exception:
        return False

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
