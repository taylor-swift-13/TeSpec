def _orig_is_prime_spec(n, output):
    if n <= 1:
        is_prime = False
    elif n == 2:
        is_prime = True
    elif n % 2 == 0:
        is_prime = False
    else:
        is_prime = True
        d = 3
        while d * d <= n:
            if n % d == 0:
                is_prime = False
                break
            d += 2
    return output == is_prime

def is_prime_spec(n, output):
    return bool(_orig_is_prime_spec(n, output))
