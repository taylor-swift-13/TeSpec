
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not (isinstance(a, int) and not isinstance(a, bool)):
        return False
    if not (isinstance(b, int) and not isinstance(b, bool)):
        return False
    if a <= 0 or b <= 0:
        return False
    return True

def postcondition(input, output):
    try:
        a, b = input
    except Exception:
        return False
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) and not isinstance(x, bool) for x in output):
        return False
    lo = a if a <= b else b
    hi = b if b >= a else a
    expected = [d for d in [2, 4, 6, 8] if lo <= d <= hi]
    return output == expected

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
