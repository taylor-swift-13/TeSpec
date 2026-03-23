def _orig_is_equal_to_sum_even_spec(n: int) -> bool:
    return n >= 8 and n % 2 == 0

def is_equal_to_sum_even_spec(n, output):
    return _orig_is_equal_to_sum_even_spec(n) == output
