def largest_divisor_spec(n, result):
    def divides(a, b):
        if a == 0:
            return b == 0
        return b % a == 0

    # Condition 1: Z.divide result n
    if not divides(result, n):
        return False
        
    # Condition 2: result < n
    if not result < n:
        return False

    # Condition 3: forall k : Z, Z.divide k n -> k < n -> k <= result
    # This is logically equivalent to saying there is no k such that:
    # result < k < n AND Z.divide k n.
    
    # For n > 1, any proper divisor k < n must be <= n // 2.
    # So we only need to check k up to n // 2 to be efficient.
    upper_bound = n
    if n > 1:
        upper_bound = (n // 2) + 1

    for k in range(result + 1, upper_bound):
        if divides(k, n):
            return False

    return True
