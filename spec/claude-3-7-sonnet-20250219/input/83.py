def _orig_starts_one_ends_spec(n: int, count: int) -> bool:
    if n <= 0:
        return False
    if n == 1:
        return count == 1
    else:
        return count == 18 * 10 ** (n - 2)

def starts_one_ends_spec(n, output):
    return bool(_orig_starts_one_ends_spec(n, output))
