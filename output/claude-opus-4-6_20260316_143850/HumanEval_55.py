
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
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
        return output == 1
    # Verify by computing Fibonacci directly
    a, b = 0, 1
    for _ in range(2, n + 1):
        a, b = b, a + b
    return output == b

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
