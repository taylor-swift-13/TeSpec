
def precondition(inp):
    n = inp[0]
    return isinstance(n, int) and n >= 0

def postcondition(inp, out):
    return isinstance(out, int) and out >= 0

def _impl(n: int):
    """Return n-th Fibonacci number.
    55
    1
    21"""
    if n == 0: return 0
    if n <= 2: return 1
    a, b = 1, 1
    for _ in range(3, n + 1):
        a, b, = b, a + b
    return b

def fib(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
