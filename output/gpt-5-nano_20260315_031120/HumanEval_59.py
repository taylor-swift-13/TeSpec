
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
    if n <= 1:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if isinstance(n, bool) or not isinstance(n, int) or n <= 1:
        return False
    if isinstance(output, bool) or not isinstance(output, int):
        return False
    if output <= 1:
        return False

    m = n
    factors = set()
    while m % 2 == 0:
        factors.add(2)
        m //= 2
    p = 3
    while p * p <= m:
        if m % p == 0:
            factors.add(p)
            while m % p == 0:
                m //= p
        p += 2
    if m > 1:
        factors.add(m)
    if not factors:
        return False
    max_factor = max(factors)
    return output == max_factor

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
