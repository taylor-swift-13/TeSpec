
def precondition(args):
    n = args[0]
    if not isinstance(n, int) or n <= 1:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return True
    return False

def postcondition(args, output):
    n = args[0]
    if not isinstance(output, int):
        return False
    
    def is_prime(k):
        if k < 2: return False
        for i in range(2, int(k**0.5) + 1):
            if k % i == 0:
                return False
        return True

    if not is_prime(output):
        return False
    if n % output != 0:
        return False
    
    for i in range(output + 1, n):
        if n % i == 0:
            if is_prime(i):
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
