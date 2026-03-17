
def precondition(input):
    if len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if a <= 0 or b <= 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    a, b = input
    if not isinstance(output, list):
        return False
    # All elements should be integers
    if not all(isinstance(x, int) for x in output):
        return False
    # All elements should be even single digits (2, 4, 6, 8)
    even_digits = {2, 4, 6, 8}
    if not all(x in even_digits for x in output):
        return False
    # Output should be in ascending order
    if output != sorted(output):
        return False
    # No duplicates
    if len(output) != len(set(output)):
        return False
    # All elements should be in the range [min(a,b), max(a,b)]
    low, high = min(a, b), max(a, b)
    if not all(low <= x <= high for x in output):
        return False
    # All even digits in range should be present
    expected = [x for x in even_digits if low <= x <= high]
    if set(output) != set(expected):
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
