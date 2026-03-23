def z_rem(a, b):
    if b == 0:
        return a
    q = abs(a) // abs(b)
    if (a < 0) != (b < 0):
        q = -q
    return a - b * q

def is_prime(p):
    if p <= 1:
        return False
    for d in range(2, p):
        if z_rem(p, d) == 0:
            return False
    return True

def is_factor(f, n):
    return z_rem(n, f) == 0

def is_prime_factor(f, n):
    return is_prime(f) and is_factor(f, n)

def largest_prime_factor_spec(n, result):
    if n <= 1:
        return False
    if is_prime(n):
        return False
    if not is_prime_factor(result, n):
        return False
    for f in range(2, n + 1):
        if is_prime_factor(f, n):
            if f > result:
                return False
    return True
