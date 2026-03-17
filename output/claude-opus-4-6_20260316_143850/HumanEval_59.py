
def precondition(input):
    (n,) = input
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False
    # n must not be prime (must be composite)
    if n < 4:
        return False
    # Check that n is not prime
    if n >= 2:
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return True
    return False


def postcondition(input, output):
    (n,) = input
    if not isinstance(output, int):
        return False
    # output must be a factor of n
    if n % output != 0:
        return False
    # output must be prime
    if output < 2:
        return False
    for i in range(2, int(output**0.5) + 1):
        if output % i == 0:
            return False
    # output must be the largest prime factor
    # Check no prime factor larger than output exists
    for candidate in range(output + 1, n + 1):
        if n % candidate == 0:
            # Check if candidate is prime
            is_prime = candidate >= 2
            for i in range(2, int(candidate**0.5) + 1):
                if candidate % i == 0:
                    is_prime = False
                    break
            if is_prime:
                return False
    return True

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
