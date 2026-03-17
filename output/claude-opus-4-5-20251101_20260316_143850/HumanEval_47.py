
def precondition(input):
    l = input[0]
    # l must be a list
    if not isinstance(l, list):
        return False
    # l must not be empty
    if len(l) == 0:
        return False
    # all elements must be numeric (int or float)
    for elem in l:
        if not isinstance(elem, (int, float)):
            return False
    return True

def postcondition(input, output):
    l = input[0]
    # output must be numeric
    if not isinstance(output, (int, float)):
        return False
    # output must be between min and max of the list
    if output < min(l) or output > max(l):
        return False
    # for odd length, median should be an element of the sorted list
    # for even length, median should be average of two middle elements
    sorted_l = sorted(l)
    n = len(sorted_l)
    if n % 2 == 1:
        expected_median = sorted_l[n // 2]
    else:
        expected_median = (sorted_l[n // 2 - 1] + sorted_l[n // 2]) / 2
    # check if output matches expected median (with tolerance for float comparison)
    if abs(output - expected_median) > 1e-9:
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
