
def precondition(input):
    l, = input
    if not isinstance(l, list):
        return False
    if len(l) == 0:
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output):
    l, = input
    if not isinstance(output, (int, float)):
        return False
    sorted_l = sorted(l)
    n = len(sorted_l)
    if n % 2 == 1:
        return output == sorted_l[n // 2]
    else:
        return output == (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2

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
