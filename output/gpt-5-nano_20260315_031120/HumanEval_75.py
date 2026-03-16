
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    a = input[0]
    if not isinstance(a, int):
        return False
    if not (a < 100):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(input[0], int):
        return False
    if not isinstance(output, bool):
        return False

    n = input[0]

    def is_prod_three_primes(x):
        if x < 2:
            return False
        count = 0
        p = 2
        while p * p <= x:
            while x % p == 0:
                count += 1
                x //= p
                if count > 3:
                    return False
            p += 1
        if x > 1:
            count += 1
        return count == 3

    expected = is_prod_three_primes(n)
    return output == expected

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
