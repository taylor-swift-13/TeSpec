def _orig_generate_integers_spec(a, b, output):
    lo = min(a, b)
    hi = min(max(a, b), 9)
    if lo <= hi:
        expected = [i for i in range(lo, hi + 1) if i % 2 == 0]
    else:
        expected = []
    return output == expected

def generate_integers_spec(a, b, output):
    return bool(_orig_generate_integers_spec(a, b, output))
