def is_prime(n):
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def _orig_prime_length_spec(s, output):
    return output == is_prime(len(s))

def prime_length_spec(string, output):
    return bool(_orig_prime_length_spec(string, output))
