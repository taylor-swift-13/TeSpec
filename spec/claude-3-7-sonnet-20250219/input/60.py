def _orig_sum_to_n_spec(n: int, output: int) -> bool:
    return output == n * (n + 1) // 2

def sum_to_n_spec(n, output):
    return bool(_orig_sum_to_n_spec(n, output))
