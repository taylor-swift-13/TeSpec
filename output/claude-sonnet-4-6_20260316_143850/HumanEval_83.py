
def precondition(input):
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 0:
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, int):
        return False
    n = input[0]
    if output < 0:
        return False
    if n == 1:
        # single digit: only "1" starts and ends with 1
        # 1-digit numbers that start or end with 1: just {1}
        return output == 1
    # n-digit numbers range from 10^(n-1) to 10^n - 1
    total = 9 * (10 ** (n - 1))
    if output > total:
        return False
    # starts with 1: 10^(n-1) numbers
    # ends with 1: 9 * 10^(n-2) numbers (first digit 1-9, last digit 1)
    # both: 10^(n-2) numbers (starts with 1 and ends with 1)
    if n >= 2:
        starts = 10 ** (n - 1)
        ends = 9 * (10 ** (n - 2))
        both = 10 ** (n - 2)
        expected = starts + ends - both
        return output == expected
    return True

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
