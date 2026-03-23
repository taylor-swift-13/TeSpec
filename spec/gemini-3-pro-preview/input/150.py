def is_prime(n):
    """
    Helper function to check primality for integers, corresponding to Coq's Znumtheory.prime.
    In Coq, prime p implies p > 1.
    """
    if n <= 1:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    d = 3
    while d * d <= n:
        if n % d == 0:
            return False
        d += 2
    return True

def x_or_y_spec(n, x, y, res):
    """
    Implements the specification:
    Definition x_or_y_spec (n x y res : Z) : Prop :=
      (prime n -> res = x) /\
      (~ prime n -> res = y).
    """
    if is_prime(n):
        # If n is prime, res must equal x
        return res == x
    else:
        # If n is not prime, res must equal y
        return res == y
