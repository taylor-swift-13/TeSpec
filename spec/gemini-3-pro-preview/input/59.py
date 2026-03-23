import math

def is_prime(k):
    if k <= 1:
        return False
    if k == 2:
        return True
    if k % 2 == 0:
        return False
    limit = math.isqrt(k)
    for i in range(3, limit + 1, 2):
        if k % i == 0:
            return False
    return True

def get_largest_prime_factor(n):
    if n == 0:
        # For n=0, every prime divides n. There is no largest prime factor.
        return None
    n = abs(n)
    if n <= 1:
        # 1 and -1 have no prime factors.
        return None
    
    max_p = -1
    d = 2
    temp = n
    # Check for 2
    if temp % 2 == 0:
        max_p = 2
        while temp % 2 == 0:
            temp //= 2
    
    # Check odd numbers
    d = 3
    while d * d <= temp:
        if temp % d == 0:
            max_p = d
            while temp % d == 0:
                temp //= d
        d += 2
    
    if temp > 1:
        max_p = temp
        
    return max_p

def largest_prime_factor_spec(n, result):
    # 1. result must be prime
    if not is_prime(result):
        return False
    
    # 2. result must divide n
    # In Coq, (result | n) means exists c, n = result * c.
    # Since result is prime (positive), n % result == 0 works for all n.
    if n % result != 0:
        return False
    
    # 3. result must be the largest prime factor
    # If n is 0, every prime k divides n. Since there are infinitely many primes,
    # there is no 'result' such that forall k, prime k -> k <= result.
    if n == 0:
        return False
    
    # For non-zero n, the set of prime factors is finite and non-empty (if |n| > 1).
    # We calculate the actual largest prime factor and compare.
    actual_largest = get_largest_prime_factor(n)
    
    return actual_largest == result
