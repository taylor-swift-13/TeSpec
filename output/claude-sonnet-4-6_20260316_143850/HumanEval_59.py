
def precondition(input):
    n = input[0]
    if not isinstance(n, int):
        return False
    if n <= 1:
        return False
    # n must not be prime (must be composite)
    if n < 4:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return True
    return False  # n is prime


def postcondition(input, output):
    n = input[0]
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
    temp = n
    largest = 1
    for i in range(2, int(temp**0.5) + 1):
        while temp % i == 0:
            largest = max(largest, i)
            temp //= i
    if temp > 1:
        largest = max(largest, temp)
    return output == largest

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
