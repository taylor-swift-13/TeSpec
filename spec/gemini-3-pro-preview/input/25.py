def is_prime(p):
    if p <= 1:
        return False
    d = 2
    while d * d <= p:
        if p % d == 0:
            return False
        d += 1
    return True

def factorize_spec(n, factors):
    prod = 1
    for f in factors:
        prod *= f

    if prod != n:
        return False

    for f in factors:
        if not is_prime(f):
            return False

    for i in range(len(factors) - 1):
        if factors[i] > factors[i+1]:
            return False

    return True
