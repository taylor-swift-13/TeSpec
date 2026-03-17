
def precondition(input):
    n = input[0]
    return isinstance(n, int) and n > 1

def postcondition(input, output):
    n = input[0]
    if not (isinstance(output, int) and output < n):
        return False
    
    # Check if output is prime
    if output < 2:
        return False
    for i in range(2, int(output**0.5) + 1):
        if output % i == 0:
            return False
            
    # Check if output is a factor of n
    return n % output == 0

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
