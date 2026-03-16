
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n > 1

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    if output >= n or output <= 0:
        return False
    if n % output != 0:
        return False
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
