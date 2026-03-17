
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if isinstance(a, bool) or isinstance(b, bool):
        return False
    if a <= 0 or b <= 0:
        return False
    return True


def postcondition(input, output):
    a, b = input
    if not isinstance(output, list):
        return False
    lo = min(a, b)
    hi = max(a, b)
    expected = [d for d in range(lo, hi + 1) if d % 2 == 0 and 0 <= d <= 9]
    if output != expected:
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
