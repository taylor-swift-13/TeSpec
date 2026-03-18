
def precondition(input):
    # input must be a tuple with a single integer n > 1
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False
    return True

def postcondition(input, output):
    # input must be a tuple with a single integer n > 1
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or n <= 1:
        return False
    # output must be an integer proper divisor of n and the largest such
    if not isinstance(output, int):
        return False
    if not (0 < output < n):
        return False
    if n % output != 0:
        return False
    for d in range(output + 1, n):
        if n % d == 0:
            return False
    return True

def _impl(n: int) -> int:
    """
    For a given number n, find the largest number that divides n evenly, smaller than n
    5
    """
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def largest_divisor(n: int) -> int:
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
