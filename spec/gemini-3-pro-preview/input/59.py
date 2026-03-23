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

def _orig_largest_prime_factor_spec(n, output):
    if not is_prime(output):
        return False
    if n % output != 0:
        return False
    if n == 0:
        return False
    actual_largest = get_largest_prime_factor(n)
    return actual_largest == output

def largest_prime_factor_spec(n, output):
    return bool(_orig_largest_prime_factor_spec(n, output))
