
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False
    # Check that n is not prime (must be composite)
    if n == 2:
        return False
    if n % 2 == 0:
        return True  # n is even and > 2, so composite
    for i in range(3, int(n**0.5) + 1, 2):
        if n % i == 0:
            return True  # n has a factor, so composite
    return False  # n is prime


def postcondition(input, output):
    n = input[0]
    if not isinstance(output, int):
        return False
    # output must be a factor of n
    if n % output != 0:
        return False
    # output must be greater than 1
    if output <= 1:
        return False
    # output must be prime
    if output == 2:
        is_prime = True
    elif output < 2 or output % 2 == 0:
        is_prime = False
    else:
        is_prime = True
        for i in range(3, int(output**0.5) + 1, 2):
            if output % i == 0:
                is_prime = False
                break
    if not is_prime:
        return False
    # output must be the largest prime factor
    # Check no prime factor larger than output exists
    for p in range(output + 1, n + 1):
        if n % p == 0:
            # Check if p is prime
            if p == 2:
                p_is_prime = True
            elif p % 2 == 0:
                p_is_prime = False
            else:
                p_is_prime = True
                for i in range(3, int(p**0.5) + 1, 2):
                    if p % i == 0:
                        p_is_prime = False
                        break
            if p_is_prime:
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
