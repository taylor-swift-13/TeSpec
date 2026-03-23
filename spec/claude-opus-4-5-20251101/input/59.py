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

def _orig_largest_prime_factor_spec(n, output):
    if n <= 1:
        return False
    if is_prime(n):
        return False
    if not is_prime_factor(output, n):
        return False
    for f in range(2, n + 1):
        if is_prime_factor(f, n):
            if f > output:
                return False
    return True

def largest_prime_factor_spec(n, output):
    return bool(_orig_largest_prime_factor_spec(n, output))
