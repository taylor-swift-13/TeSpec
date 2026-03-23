def divides(d, n):
    if d == 0:
        return n == 0
    return n % d == 0

def _orig_is_prime_spec(n, b):
    if n <= 1:
        is_p = False
    else:
        is_p = True
        for d in range(2, n):
            if divides(d, n):
                is_p = False
                break
    return b == is_p

def is_prime_spec(n, output):
    return bool(_orig_is_prime_spec(n, output))
