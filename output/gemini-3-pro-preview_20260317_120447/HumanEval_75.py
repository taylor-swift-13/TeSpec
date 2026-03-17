
def precondition(args):
    a = args[0]
    return isinstance(a, int) and a < 100

def postcondition(args, output):
    a = args[0]
    if not isinstance(output, bool):
        return False
    
    def is_prime(n):
        if n < 2:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True

    primes = [n for n in range(2, 100) if is_prime(n)]
    
    possible = False
    for p1 in primes:
        for p2 in primes:
            for p3 in primes:
                if p1 * p2 * p3 == a:
                    possible = True
                    break
            if possible: break
        if possible: break
        
    return output == possible

def _impl(a):
    """Write a function that returns true if the given number is the multiplication of 3 prime numbers
    and false otherwise.
    Knowing that (a) is less then 100. 
    Example:
    is_multiply_prime(30) == True
    30 = 2 * 3 * 5"""
    if a <= 1: return False
    isprime = [True] * (a + 1)
    for i in range(2, a + 1):
        if isprime[i]:
            for j in range(i + i, a + 1, i):
                isprime[j] = False
    cnt, tmp = 0, a
    for i in range(2, a + 1):
        while isprime[i] and tmp % i == 0:
            tmp //= i
            cnt += 1
    return cnt == 3

def is_multiply_prime(a):
    _input = (a,)
    assert precondition(_input)
    _output = _impl(a)
    assert postcondition(_input, _output)
    return _output
