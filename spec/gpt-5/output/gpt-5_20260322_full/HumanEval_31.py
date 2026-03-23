import math

def divides(d, n):
    if d == 0:
        return n == 0
    return n % d == 0

def is_prime_pred(n):
    if n < 2:
        return False
    limit = math.isqrt(n)
    for i in range(2, limit + 1):
        if divides(i, n):
            return False
    return True

def is_prime_spec(n, b):
    return b == is_prime_pred(n)

def _impl(n):
    if n <= 1: return False
    n_sqrt = 1
    while n_sqrt ** 2 < n: n_sqrt += 1
    for i in range(2, min(n_sqrt + 1, n)):
        if n % i == 0:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_prime_spec(*input, output))

def is_prime(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
