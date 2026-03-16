
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if a <= 0 or b <= 0:
        return False
    return True

def postcondition(input, output):
    # Basic checks on input
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    # Output must be a list of integers
    if not isinstance(output, list):
        return False
    for x in output:
        if not isinstance(x, int):
            return False
        # must be a single digit and even
        if x < 0 or x > 9 or x % 2 != 0:
            return False
    # must be sorted in ascending order and have no duplicates
    if output != sorted(output):
        return False
    if len(output) != len(set(output)):
        return False
    # Expected values: even digits within the inclusive range [min(a,b), max(a,b)]
    lo = min(a, b)
    hi = max(a, b)
    expected = [d for d in range(lo, hi + 1) if 0 <= d <= 9 and d % 2 == 0]
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
