
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if a <= 0 or b <= 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    a, b = input
    if not isinstance(a, int) or not isinstance(b, int):
        return False
    if a <= 0 or b <= 0:
        return False
    if not isinstance(output, list):
        return False

    def _digits_all_even(n):
        for ch in str(n):
            if ch not in '02468':
                return False
        return True

    lo, hi = (a, b) if a <= b else (b, a)
    expected = [x for x in range(lo, hi + 1) if _digits_all_even(x)]
    return output == expected

def _impl(a, b):
    """
    Given two positive integers a and b, return the even digits between a
    and b, in ascending order.

    For example:
    generate_integers(2, 8) => [2, 4, 6, 8]
    generate_integers(8, 2) => [2, 4, 6, 8]
    generate_integers(10, 14) => []
    """
    if a > b: a, b = b, a
    return [i for i in range(a, min(b + 1, 10)) if i % 2 == 0]

def generate_integers(a, b):
    _input = (a, b)
    assert precondition(_input)
    _output = _impl(a, b)
    assert postcondition(_input, _output)
    return _output
