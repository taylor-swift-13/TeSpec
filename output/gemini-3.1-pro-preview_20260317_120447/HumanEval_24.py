
def precondition(inp):
    n = inp[0]
    return isinstance(n, int) and n > 1

def postcondition(inp, out):
    n = inp[0]
    if not isinstance(out, int) or isinstance(out, bool):
        return False
    if out < 1 or out >= n:
        return False
    if n % out != 0:
        return False
    return all(n % i != 0 for i in range(out + 1, n))

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
