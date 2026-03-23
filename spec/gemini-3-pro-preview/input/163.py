def _orig_generate_integers_spec(a: int, b: int, l: list) -> bool:
    lower = min(a, b)
    upper = max(a, b)
    expected = [x for x in range(lower, upper + 1) if x < 10 and x % 2 == 0]
    return l == expected

def generate_integers_spec(a, b, output):
    return bool(_orig_generate_integers_spec(a, b, output))
