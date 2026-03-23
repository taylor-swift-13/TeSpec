def _orig_count_up_to_spec(n, output):
    """
    Python implementation of the Coq specification count_up_to_spec.
    The specification defines that 'output' is a list containing exactly the prime numbers
    in the range [2, n).
    """

    def is_prime_helper(x):
        """
        Checks the primality condition defined in the spec:
        (forall d, 2 <= d < x -> x mod d <> 0)
        """
        for d in range(2, x):
            if x % d == 0:
                return False
        return True
    for x in output:
        if not 2 <= x < n:
            return False
        if not is_prime_helper(x):
            return False
    for x in range(2, n):
        if is_prime_helper(x):
            if x not in output:
                return False
    return True

def count_up_to_spec(n, output):
    return bool(_orig_count_up_to_spec(n, output))
