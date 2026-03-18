
def precondition(input):
    # input should be a tuple with exactly one argument: n (int) and n >= 0
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    return True

def postcondition(input, output):
    # output should be the n-th Fibonacci number, with F(0)=0, F(1)=1
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or n < 0:
        return False
    if not isinstance(output, int):
        return False

    # compute F(n) iteratively
    a, b = 0, 1
    for _ in range(n):
        a, b = b, a + b
    return output == a

def _impl(n: int):
    """
    Return n-th Fibonacci number.
    55
    1
    21
    """
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
