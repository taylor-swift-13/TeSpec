def starts_one_ends_spec(n: int, result: int) -> bool:
    if n == 1:
        expected = 1
    else:
        expected = int(18 * (10 ** (n - 2)))
    return result == expected
