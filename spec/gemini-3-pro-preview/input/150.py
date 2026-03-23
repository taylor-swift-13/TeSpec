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

def _orig_x_or_y_spec(n, x, y, output):
    """
    Implements the specification:
    Definition x_or_y_spec (n x y output : Z) : Prop :=
      (prime n -> output = x) /      (~ prime n -> output = y).
    """
    if is_prime(n):
        return output == x
    else:
        return output == y

def x_or_y_spec(n, x, y, output):
    return bool(_orig_x_or_y_spec(n, x, y, output))
