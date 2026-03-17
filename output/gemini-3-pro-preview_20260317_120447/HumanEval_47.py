
def precondition(args):
    l = args[0]
    return isinstance(l, list) and len(l) > 0 and all(isinstance(x, (int, float)) for x in l)

def postcondition(args, output):
    l = args[0]
    n = len(l)
    s = sorted(l)
    if n % 2 == 1:
        expected = float(s[n // 2])
    else:
        expected = (s[n // 2 - 1] + s[n // 2]) / 2.0
    return float(output) == expected

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
