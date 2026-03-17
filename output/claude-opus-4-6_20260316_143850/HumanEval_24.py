
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    # n must be greater than 1 to have a divisor smaller than n and greater than 0
    if n <= 1:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    # output must be a divisor of n
    if n % output != 0:
        return False
    # output must be smaller than n
    if output >= n:
        return False
    # output must be at least 1
    if output < 1:
        return False
    # output must be the largest such divisor: no integer between output+1 and n-1 divides n
    for i in range(output + 1, n):
        if n % i == 0:
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
