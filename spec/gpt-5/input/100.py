def _orig_make_a_pile_spec(n, output):
    return output == [n + 2 * i for i in range(n)]

def make_a_pile_spec(n, output):
    return bool(_orig_make_a_pile_spec(n, output))
