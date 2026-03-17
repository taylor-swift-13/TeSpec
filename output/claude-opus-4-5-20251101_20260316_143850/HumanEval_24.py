
def precondition(input):
    n = input[0]
    # n must be an integer greater than 1 (since we need a divisor smaller than n)
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    # output must be a positive integer smaller than n
    if not isinstance(output, int):
        return False
    if output <= 0 or output >= n:
        return False
    # output must divide n evenly
    if n % output != 0:
        return False
    # output must be the largest such divisor (no larger divisor exists between output and n)
    for d in range(output + 1, n):
        if n % d == 0:
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
