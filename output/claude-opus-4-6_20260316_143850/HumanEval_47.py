
def precondition(input):
    l = input[0]
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    if not isinstance(output, (int, float)):
        return False
    n = len(l)
    sorted_l = sorted(l)
    if n % 2 == 1:
        expected = sorted_l[n // 2]
    else:
        expected = (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2
    if abs(output - expected) > 1e-9:
        return False
    return True

def _impl(l: list):
    """Return median of elements in the list l.
    3
    15.0"""
    sorted_l = sorted(l)
    if len(l) % 2 == 1:
        return sorted_l[len(l) // 2]
    else:
        return (sorted_l[len(l) // 2 - 1] + sorted_l[len(l) // 2]) / 2

def median(l: list):
    _input = (l,)
    assert precondition(_input)
    _output = _impl(l)
    assert postcondition(_input, _output)
    return _output
