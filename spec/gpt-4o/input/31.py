def _orig_is_prime_spec(n, output):
    if n <= 1:
        return output is False
    for i in range(2, n):
        if n % i == 0:
            return output is False
    return output is True

def is_prime_spec(n, output):
    return bool(_orig_is_prime_spec(n, output))
