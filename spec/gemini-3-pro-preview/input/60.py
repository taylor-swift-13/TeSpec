def _orig_sum_to_n_spec(n, output):
    return output == (n + 1) * n // 2

def sum_to_n_spec(n, output):
    return bool(_orig_sum_to_n_spec(n, output))
