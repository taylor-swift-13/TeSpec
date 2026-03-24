def _orig_simplify_spec(x1, x2, n1, n2, output):
    return x2 > 0 and n2 > 0 and ((x1 * n1 % (x2 * n2) == 0) == output)

# Old incorrect translation:
# def simplify_spec(x, n, output):
#     return bool(_orig_simplify_spec(x, n, output[0], output[1], output[2]))
def simplify_spec(x, n, output):
    try:
        x1, x2 = map(int, x.split("/"))
        n1, n2 = map(int, n.split("/"))
    except (AttributeError, TypeError, ValueError):
        return False
    return bool(_orig_simplify_spec(x1, x2, n1, n2, output))
