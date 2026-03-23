def _orig_starts_one_ends_spec(n: int, output: int) -> bool:
    if n <= 0:
        return False
    if n == 1:
        return output == 1
    return output == 18 * 10 ** (n - 2)

def starts_one_ends_spec(n, output):
    return bool(_orig_starts_one_ends_spec(n, output))
