
def precondition(input):
    l = input[0]
    return isinstance(l, list) and len(l) > 0 and all(isinstance(x, (int, float)) for x in l)

def postcondition(input, output):
    return isinstance(output, (int, float))

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
