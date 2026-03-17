
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n > 1

def postcondition(input, output):
    n = input[0]
    return isinstance(output, int) and n % output == 0 and output < n and all(not (n % i == 0 and i > output) for i in range(1, n))

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
