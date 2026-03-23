import math

def divides(d, n):
    if d == 0:
        return n == 0
    return n % d == 0

def is_prime_pred(n):
    if n < 2:
        return False
    limit = math.isqrt(n)
    for i in range(2, limit + 1):
        if divides(i, n):
            return False
    return True

def is_prime_spec(n, b):
    return b == is_prime_pred(n)
