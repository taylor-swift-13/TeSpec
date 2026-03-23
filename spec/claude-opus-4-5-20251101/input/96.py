def is_prime(p):
    if p < 2:
        return False
    d = 2
    while d * d <= p:
        if p % d == 0:
            return False
        d += 1
    return True

def _orig_count_up_to_spec(n, output):
    if n < 0:
        return False
    expected = [x for x in range(2, n) if is_prime(x)]
    return output == expected

def count_up_to_spec(n, output):
    return bool(_orig_count_up_to_spec(n, output))
