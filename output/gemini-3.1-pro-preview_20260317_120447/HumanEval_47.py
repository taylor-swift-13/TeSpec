
def precondition(args):
    if len(args) != 1:
        return False
    l = args[0]
    if not isinstance(l, list) or len(l) == 0:
        return False
    return all(isinstance(x, (int, float)) for x in l)

def postcondition(args, output):
    l = args[0]
    if not isinstance(output, (int, float)):
        return False
    return min(l) <= output <= max(l)

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
