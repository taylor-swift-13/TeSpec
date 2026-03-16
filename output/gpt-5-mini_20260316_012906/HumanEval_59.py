
def is_prime(n: int) -> bool:
    if not isinstance(n, int) or n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    import math
    limit = math.isqrt(n)
    i = 3
    while i <= limit:
        if n % i == 0:
            return False
        i += 2
    return True

def prime_factors_list(n: int):
    if not isinstance(n, int) or n < 2:
        return []
    factors = []
    while n % 2 == 0:
        factors.append(2)
        n //= 2
    f = 3
    import math
    while f * f <= n:
        while n % f == 0:
            factors.append(f)
            n //= f
        f += 2
    if n > 1:
        factors.append(n)
    return factors

def precondition(input) -> bool:
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) < 1:
            return False
        n = input[0]
        if not isinstance(n, int):
            return False
        if not (n > 1):
            return False
        if is_prime(n):
            return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        if not precondition(input):
            return True
        n = input[0]
        if not isinstance(output, int):
            return False
        if output < 2:
            return False
        if n % output != 0:
            return False
        if not is_prime(output):
            return False
        factors = prime_factors_list(n)
        if not factors:
            return False
        return output == max(factors)
    except Exception:
        return False

def _impl(n: int):
    """Return the largest prime factor of n. Assume n > 1 and is not a prime.
    29
    2"""
    isprime = [True] * (n + 1)
    for i in range(2, n + 1):
        if isprime[i]:
            for j in range(i + i, n, i):
                isprime[j] = False
    for i in range(n - 1, 0, -1):
        if isprime[i] and n % i == 0:
            return i

def largest_prime_factor(n: int):
    _input = (n,)
    assert precondition(_input)
    _output = _impl(n)
    assert postcondition(_input, _output)
    return _output
