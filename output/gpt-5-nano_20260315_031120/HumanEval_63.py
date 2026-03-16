
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, int):
        return False
    n = input[0]
    if n == 0 or n == 1:
        expected = 0
    elif n == 2:
        expected = 1
    else:
        t0, t1, t2 = 0, 0, 1  # f(0)=0, f(1)=0, f(2)=1
        for _ in range(3, n + 1):
            f = t2 + t1 + t0
            t0, t1, t2 = t1, t2, f
        expected = t2
    return output == expected

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
