def _orig_fruit_distribution_spec(s, n, mangoes):
    return 0 <= mangoes <= n

def fruit_distribution_spec(s, n, output):
    return bool(_orig_fruit_distribution_spec(s, n, output))
