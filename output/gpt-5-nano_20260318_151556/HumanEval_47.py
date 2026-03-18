
def precondition(input):
    # input should be a tuple with a single element: a non-empty list of numbers (ints or floats)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list) or len(l) == 0:
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output):
    # output should be the median of the list provided in input
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    l = input[0]
    if not isinstance(l, list) or len(l) == 0:
        return False
    for x in l:
        if not isinstance(x, (int, float)):
            return False
    sorted_l = sorted(l)
    n = len(sorted_l)
    if n % 2 == 1:
        expected = sorted_l[n // 2]
    else:
        expected = (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2.0
    try:
        if isinstance(output, float) or isinstance(expected, float):
            tol = 1e-9
            return abs(output - expected) <= tol
        else:
            return output == expected
    except Exception:
        return False

def _impl(l: list):
    """
    Return median of elements in the list l.
    3
    15.0
    """
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
