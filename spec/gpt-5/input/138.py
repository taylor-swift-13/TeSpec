def _orig_is_equal_to_sum_even_spec(n: int, output: bool) -> bool:
    return output == (n >= 8 and n % 2 == 0)

def is_equal_to_sum_even_spec(n, output):
    return bool(_orig_is_equal_to_sum_even_spec(n, output))
