
def precondition(inp):
    n = inp[0]
    return type(n) is int and n > 1

def postcondition(inp, out):
    n = inp[0]
    if type(out) is not int:
        return False
    if out < 2 or n % out != 0:
        return False
        
    def is_prime(x):
        if x < 2: return False
        if x in (2, 3): return True
        if x % 2 == 0 or x % 3 == 0: return False
        for i in range(5, int(x**0.5) + 1, 6):
            if x % i == 0 or x % (i + 2) == 0:
                return False
        return True

    if not is_prime(out):
        return False
        
    for i in range(1, int(n**0.5) + 1):
        if n % i == 0:
            if i > out and is_prime(i):
                return False
            if n // i > out and is_prime(n // i):
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
