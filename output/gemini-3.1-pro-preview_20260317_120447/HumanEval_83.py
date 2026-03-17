
def precondition(inp):
    n, = inp
    return isinstance(n, int) and n > 0

def postcondition(inp, out):
    n, = inp
    if not isinstance(out, int):
        return False
    if n == 1:
        return out == 1
    return out == 18 * 10**(n - 2)

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
