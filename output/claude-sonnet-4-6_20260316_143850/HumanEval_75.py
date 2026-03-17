
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
    
    # Check if a can be expressed as product of exactly 3 primes (with repetition)
    found = False
    if a >= 2:
        for i in range(2, a):
            if not is_prime(i):
                continue
            if a % i == 0:
                remainder = a // i
                for j in range(2, remainder):
                    if not is_prime(j):
                        continue
                    if remainder % j == 0:
                        k = remainder // j
                        if is_prime(k):
                            found = True
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
