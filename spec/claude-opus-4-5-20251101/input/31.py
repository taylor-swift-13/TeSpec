def is_prime_spec(n, result):
    # Calculate whether n is actually prime based on the logic:
    # (forall d : Z, 2 <= d -> d < n -> Z.rem n d <> 0)
    # Note: For n > 1, Z.rem n d is equivalent to n % d in Python since n and d are positive.
    
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

    # The spec states:
    # 1. (n <= 1 -> result = false)
    # 2. (n > 1 -> (result = true <-> is_prime))
    # Both cases are satisfied if result == is_prime
    return result == is_prime
