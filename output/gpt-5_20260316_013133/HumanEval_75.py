
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and type(input[0]) is int and input[0] < 100

def postcondition(input, output):
    if not precondition(input):
        return True
    a = input[0]
    def is_product_of_three_primes(n):
        if n <= 1:
            return False
        m = n
        count = 0
        p = 2
        while p * p <= m:
            while m % p == 0:
                m //= p
                count += 1
                if count > 3:
                    return False
            p += 1
        if m > 1:
            count += 1
        return count == 3
    return isinstance(output, bool) and (output == is_product_of_three_primes(a))

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
