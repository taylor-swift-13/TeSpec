
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 1:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # For n=1, only "1" starts or ends with 1, so count is 1
    if n == 1:
        return output == 1
    # For n >= 2:
    # Numbers starting with 1: 10^(n-1) (from 10...0 to 19...9)
    # Numbers ending with 1: 9 * 10^(n-2) (first digit 1-9, middle digits 0-9, last digit 1)
    # Numbers starting AND ending with 1: 10^(n-2)
    # By inclusion-exclusion: 10^(n-1) + 9*10^(n-2) - 10^(n-2) = 10^(n-1) + 8*10^(n-2)
    # = 10^(n-2) * (10 + 8) = 18 * 10^(n-2)
    expected = 18 * (10 ** (n - 2))
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
