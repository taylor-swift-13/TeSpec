
def precondition(input):
    n, = input
    return isinstance(n, int) and n > 0

def postcondition(input, output):
    n, = input
    if not isinstance(output, int):
        return False
    if n == 1:
        return output == 1
    min_possible = 2 * (10 ** (n - 1))
    max_possible = 2 * (10 ** (n - 1))
    return min_possible <= output <= max_possible

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
