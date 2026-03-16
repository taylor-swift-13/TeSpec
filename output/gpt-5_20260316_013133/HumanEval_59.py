
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    n = input[0]
    if not isinstance(n, int) or n <= 1:
        return False

    def is_prime(k):
        if not isinstance(k, int) or k <= 1:
            return False
        if k % 2 == 0:
            return k == 2
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True

    return not is_prime(n)


def postcondition(input, output):
    # Postcondition only applies when precondition holds
    if not precondition(input):
        return True

    n = input[0]

    def is_prime(k):
        if not isinstance(k, int) or k <= 1:
            return False
        if k % 2 == 0:
            return k == 2
        i = 3
        while i * i <= k:
            if k % i == 0:
                return False
            i += 2
        return True

    if not isinstance(output, int):
        return False
    if output <= 1:
        return False
    if n % output != 0:
        return False
    if not is_prime(output):
        return False

    # Compute largest prime factor of n
    max_p = None
    d = 2
    while d * d <= n:
        if n % d == 0:
            if is_prime(d):
                if max_p is None or d > max_p:
                    max_p = d
            other = n // d
            if is_prime(other):
                if max_p is None or other > max_p:
                    max_p = other
        d += 1
    # As n is composite per precondition, max_p should be found
    return max_p == output

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
