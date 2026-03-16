
def precondition(input):
    a, b = input
    return isinstance(a, int) and isinstance(b, int) and a > 0 and b > 0

def postcondition(input, output):
    a, b = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    if not all(x % 2 == 0 for x in output):
        return False
    lo, hi = min(a, b), max(a, b)
    if not all(lo <= x <= hi for x in output):
        return False
    if len(output) > 0:
        if not all(output[i] < output[i+1] for i in range(len(output)-1)):
            return False
    return True

def _impl(a, b):
    """Given two positive integers a and b, return the even digits between a
    and b, in ascending order.

    For example:
    generate_integers(2, 8) => [2, 4, 6, 8]
    generate_integers(8, 2) => [2, 4, 6, 8]
    generate_integers(10, 14) => []"""
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def generate_integers(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
