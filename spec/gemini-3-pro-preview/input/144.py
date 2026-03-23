def _orig_simplify_spec(x1, x2, n1, n2, output):
    if x2 * n2 == 0:
        return True
    return bool(output) == (x1 * n1 % (x2 * n2) == 0)

def simplify_spec(x, n, output):
    return bool(_orig_simplify_spec(x, n, output[0], output[1], output[2]))
