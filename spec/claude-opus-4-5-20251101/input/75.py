def is_prime(n):
    """
    Checks if n is a prime number according to the Coq definition:
    n > 1 /\ forall d : Z, 1 < d < n -> Z.rem n d <> 0.
    """
    if n <= 1:
        return False
    # Standard primality test is equivalent to the Coq definition.
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def prime_factorization(n, factors):
    """
    Checks if the list 'factors' is a valid prime factorization of 'n'
    according to the inductive definition prime_factorization.
    """
    if n == 1:
        return factors == []
    if n <= 1:
        return False
    
    current_n = n
    for p in factors:
        # pf_cons requirements:
        # n > 1 (checked by current_n > 1)
        # is_prime p
        # Z.rem n p = 0
        # prime_factorization (Z.div n p) rest
        if current_n <= 1:
            return False
        if not is_prime(p):
            return False
        if current_n % p != 0:
            return False
        current_n //= p
    
    # After all factors, we must reach 1 (pf_one).
    return current_n == 1

def _orig_is_multiply_prime_spec(a, output):
    """
    Checks if 'output' correctly indicates whether 'a' is a product of exactly three primes.
    Coq definition:
    (output = true <-> (a > 1 /\\ exists p1 p2 p3 : Z, is_prime p1 /\\ is_prime p2 /\\ is_prime p3 /\\ a = p1 * p2 * p3))
    """
    if a <= 1:
        condition = False
    else:
        factors_count = 0
        temp = a
        d = 2
        while d * d <= temp:
            while temp % d == 0:
                factors_count += 1
                temp //= d
            d += 1
        if temp > 1:
            factors_count += 1
        condition = factors_count == 3
    return output == condition

def is_multiply_prime_spec(a, output):
    return bool(_orig_is_multiply_prime_spec(a, output))
