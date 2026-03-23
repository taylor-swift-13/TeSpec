def is_equal_to_sum_even_spec(n: int, res: bool) -> bool:
    return res == ((n >= 8) and (n % 2 == 0))
