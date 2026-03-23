def starts_one_ends_spec(n: int, result: int) -> bool:
    if n <= 0:
        return False
    if n == 1:
        return result == 1
    return result == 18 * (10 ** (n - 2))
