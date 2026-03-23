def simplify_spec(x1, x2, n1, n2, result):
    return (x2 > 0) and (n2 > 0) and (((x1 * n1) % (x2 * n2) == 0) == result)
