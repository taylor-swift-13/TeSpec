import math

def largest_divisor_spec(n: int, result: int) -> bool:
    if n < 0:
        # For negative n, the minimum divisor is n itself.
        # There are no divisors strictly less than n.
        return False
    if n == 0:
        # Every integer divides 0. The largest integer strictly less than 0 is -1.
        return result == -1
    if n == 1:
        # The divisors of 1 are 1 and -1. The largest strictly less than 1 is -1.
        return result == -1
    
    # For n > 1, the largest divisor strictly less than n is n // smallest_prime_factor
    spf = n
    for i in range(2, math.isqrt(n) + 1):
        if n % i == 0:
            spf = i
            break
            
    best_k = n // spf
    return result == best_k

def _impl(n: int) -> int:
    for i in range(2, n):
        if n % i == 0: return n // i
    return 1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_divisor_spec(*input, output))

def largest_divisor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
