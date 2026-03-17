
def precondition(input):
    a, b = input
    return isinstance(a, int) and isinstance(b, int) and a > 0 and b > 0

def postcondition(input, output):
    a, b = input
    low = min(a, b)
    high = max(a, b)
    if not isinstance(output, list):
        return False
    # All elements should be even single digits between low and high inclusive
    for x in output:
        if not isinstance(x, int):
            return False
        if x % 2 != 0:
            return False
        if x < 1 or x > 9:
            return False
        if x < low or x > high:
            return False
    # Should be in ascending order
    for i in range(len(output) - 1):
        if output[i] >= output[i + 1]:
            return False
    # No duplicates
    if len(output) != len(set(output)):
        return False
    # Should contain all even single digits in range
    expected = [d for d in range(low, high + 1) if d in (2, 4, 6, 8)]
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
