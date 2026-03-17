
def precondition(input_args):
    n = input_args[0]
    return isinstance(n, int) and n >= 0

def postcondition(input_args, output):
    n = input_args[0]
    if not isinstance(output, int) or output < 0:
        return False
    if n == 0:
        return output == 0
    if n == 1 or n == 2:
        return output == 1
    
    def is_perfect_square(x):
        if x < 0: return False
        s = int(x**0.5)
        return s*s == x
    
    is_fib = is_perfect_square(5 * output * output + 4) or is_perfect_square(5 * output * output - 4)
    if not is_fib:
        return False
    
    phi = (1 + 5**0.5) / 2
    approx = (phi**n) / (5**0.5)
    return abs(output - approx) < 1.0 or output == 0

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
