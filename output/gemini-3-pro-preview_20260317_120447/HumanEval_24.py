
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n > 1

def postcondition(args, output):
    n = args[0]
    if not (isinstance(output, int) and output < n and n % output == 0):
        return False
    for k in range(output + 1, n):
        if n % k == 0:
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
