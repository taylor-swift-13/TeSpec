
def precondition(inp):
    n = inp[0]
    return isinstance(n, int) and n >= 0

def postcondition(inp, out):
    n = inp[0]
    if not isinstance(out, int):
        return False
    if n == 0:
        return out == 0
    if n == 1:
        return out == 0
    if n == 2:
        return out == 1
    if n >= 3:
        return out >= 1
    return True

def _impl(n: int):
    """The FibFib number sequence is a sequence similar to the Fibbonacci sequnece that's defined as follows:
    fibfib(0) == 0
    fibfib(1) == 0
    fibfib(2) == 1
    fibfib(n) == fibfib(n-1) + fibfib(n-2) + fibfib(n-3).
    Please write a function to efficiently compute the n-th element of the fibfib number sequence.
    0
    4
    24"""
    if n == 0 or n == 1:
        return 0
    elif n == 2:
        return 1
    a, b, c = 0, 0, 1
    for _ in range(3, n + 1):
        a, b, c = b, c, a + b + c
    return c

def fibfib(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
