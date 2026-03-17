
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    if isinstance(n, bool):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # Check base cases
    if n == 0:
        return output == 0
    if n == 1:
        return output == 0
    if n == 2:
        return output == 1
    # For larger n, verify by computing the sequence
    if n <= 20:
        fibfib = [0, 0, 1]
        for i in range(3, n + 1):
            fibfib.append(fibfib[i-1] + fibfib[i-2] + fibfib[i-3])
        return output == fibfib[n]
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
