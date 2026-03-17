
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n >= 1

def postcondition(args, output):
    n = args[0]
    if n == 1:
        expected = 1
    else:
        # |Starts with 1| = 10^(n-1)
        # |Ends with 1| = 9 * 10^(n-2)
        # |Starts and Ends with 1| = 10^(n-2)
        # Total = 10^(n-1) + 9 * 10^(n-2) - 10^(n-2) = 10^(n-1) + 8 * 10^(n-2)
        expected = 10**(n-1) + 8 * 10**(n-2)
    return output == expected

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
