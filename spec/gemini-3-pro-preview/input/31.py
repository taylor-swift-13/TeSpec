def is_prime(n):
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    i = 3
    while i * i <= n:
        if n % i == 0:
            return False
        i += 2
    return True

def _orig_is_prime_spec(n, output):
    return output == is_prime(n)

def is_prime_spec(n, output):
    return bool(_orig_is_prime_spec(n, output))
