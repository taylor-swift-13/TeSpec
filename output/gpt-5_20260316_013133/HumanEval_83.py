
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    n = input[0]
    if n == 1:
        expected = 1
    else:
        expected = 18 * (10 ** (n - 2))
    try:
        return output == expected
    except Exception:
        return False

def _impl(n):
    """Given a positive integer n, return the count of the numbers of n-digit
    positive integers that start or end with 1."""
    if n == 1: return 1
    return 18 * 10 ** (n - 2)

def starts_one_ends(n):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
