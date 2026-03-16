
def precondition(args):
    n = args[0]
    return isinstance(n, int) and n > 1

def postcondition(args, result):
    n = args[0]
    if not isinstance(result, int):
        return False
    if result <= 1:
        return False
    # Check result is a factor
    if n % result != 0:
        return False
    # Check result is prime
    for i in range(2, int(result**0.5) + 1):
        if result % i == 0:
            return False
    # Check no larger prime factor exists
    remaining = n // result
    for i in range(result + 1, remaining + 1):
        if remaining % i == 0:
            # Check if i is prime
            is_prime = True
            for j in range(2, int(i**0.5) + 1):
                if i % j == 0:
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
