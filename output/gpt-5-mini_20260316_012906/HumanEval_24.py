
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    # require n >= 2 so a proper positive divisor exists (at least 1)
    if n < 2:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    n = input[0]
    # output must be an integer divisor strictly less than n and at least 1
    if not isinstance(output, int):
        return False
    if not (1 <= output < n):
        return False
    if n % output != 0:
        return False
    # output must be the largest such divisor: no other divisor in [1, n) is greater
    for k in range(1, n):
        if n % k == 0 and k > output:
            return False
    return True

def _impl(n: int) -> int:
    """For a given number n, find the largest number that divides n evenly, smaller than n
    5"""
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def largest_divisor(n: int) -> int:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
