def _orig_make_a_pile_spec(n: int, output: list) -> bool:
    expected = [n + 2 * i for i in range(max(0, n))]
    return output == expected

def make_a_pile_spec(n, output):
    return bool(_orig_make_a_pile_spec(n, output))
