def has_divisor_upto(n, k):
    for i in range(k, 1, -1):
        if n % i == 0:
            return True
    return False

def is_primeb(a):
    if a < 2:
        return False
    return not has_divisor_upto(a, a - 1)

def _orig_prime_length_spec(s, b):
    return b == is_primeb(len(s))

def prime_length_spec(string, output):
    return bool(_orig_prime_length_spec(string, output))
