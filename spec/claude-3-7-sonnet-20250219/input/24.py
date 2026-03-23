def largest_divisor_spec(n: int, d: int) -> bool:
    if n <= 1:
        return True
    if not (1 < d < n):
        return False
    if n % d != 0:
        return False
    for k in range(2, n):
        if n % k == 0:
            if d > k:
                return False
    return True
