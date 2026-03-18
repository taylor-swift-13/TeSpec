
def precondition(input) -> bool:
    # input should be a tuple of exactly one argument: n
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False  # n must be > 1
    def is_prime(x: int) -> bool:
        if x < 2:
            return False
        if x % 2 == 0:
            return x == 2
        i = 3
        while i * i <= x:
            if x % i == 0:
                return False
            i += 2
        return True
    if is_prime(n):
        return False  # n must not be prime
    return True

def postcondition(input, output) -> bool:
    # input should be a tuple of exactly one argument: n
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int):
        return False
    if not isinstance(output, int):
        return False
    def largest_prime_factor(x: int) -> int:
        m = x
        last = None
        while m % 2 == 0:
            last = 2
            m //= 2
        f = 3
        while f * f <= m:
            while m % f == 0:
                last = f
                m //= f
            f += 2
        if m > 1:
            last = m
        return last
    expected = largest_prime_factor(n)
    return output == expected

def _impl(n: int):
    """
    Return the largest prime factor of n. Assume n > 1 and is not a prime.
    29
    2
    """
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
