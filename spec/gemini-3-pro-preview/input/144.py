def simplify_spec(x1, x2, n1, n2, result):
    if x2 * n2 == 0:
        return True
    return bool(result) == (((x1 * n1) % (x2 * n2)) == 0)
