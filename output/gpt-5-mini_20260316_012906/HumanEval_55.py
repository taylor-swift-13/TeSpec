
def precondition(input) -> bool:
    # Expect a single positional integer argument n with n >= 1
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        n = input[0]
        if not isinstance(n, int):
            return False
        if n < 1:
            return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    # If precondition doesn't hold, consider postcondition vacuously true
    if not precondition(input):
        return True
    n = input[0]
    # Output must be an int and equal to the n-th Fibonacci with F(1)=1, F(2)=1
    if not isinstance(output, int):
        return False
    # compute fibonacci iteratively
    if n == 1 or n == 2:
        expected = 1
    else:
        a, b = 1, 1
        i = 3
        while i <= n:
            a, b = b, a + b
            i += 1
        expected = b
    return output == expected

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
