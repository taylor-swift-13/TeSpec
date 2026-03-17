
def precondition(input):
    if len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int):
        return False
    if a < 1 or a >= 100:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    a = input[0]
    
    def is_prime(n):
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                return False
        return True
    
    def get_primes_up_to(n):
        primes = []
        for i in range(2, n + 1):
            if is_prime(i):
                primes.append(i)
        return primes
    
    primes = get_primes_up_to(a)
    
    found = False
    for i in range(len(primes)):
        if primes[i] > a:
            break
        for j in range(i, len(primes)):
            if primes[i] * primes[j] > a:
                break
            for k in range(j, len(primes)):
                product = primes[i] * primes[j] * primes[k]
                if product > a:
                    break
                if product == a:
                    found = True
                    break
            if found:
                break
        if found:
            break
    
    return output == found

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
