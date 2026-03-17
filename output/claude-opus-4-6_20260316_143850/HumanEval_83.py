
def precondition(input):
    (n,) = input
    return isinstance(n, int) and n >= 1

def postcondition(input, output):
    (n,) = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    if n == 1:
        return output == 1
    # Count of n-digit numbers starting with 1: 10^(n-1)
    # Count of n-digit numbers ending with 1: 9 * 10^(n-2) (first digit 1-9, last digit 1, middle digits 0-9)
    # Overlap (start and end with 1): 10^(n-2)
    # Total = 10^(n-1) + 9 * 10^(n-2) - 10^(n-2) = 10^(n-1) + 8 * 10^(n-2)
    expected = 10 ** (n - 1) + 8 * 10 ** (n - 2)
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
