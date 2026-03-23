def _orig_starts_one_ends_spec(n: int, output: int) -> bool:
    if n == 1:
        expected = 1
    else:
        expected = int(18 * 10 ** (n - 2))
    return output == expected

def starts_one_ends_spec(n, output):
    return bool(_orig_starts_one_ends_spec(n, output))
