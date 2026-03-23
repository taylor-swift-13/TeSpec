def poly(xs, x):
    if not xs:
        return 0
    return xs[0] + x * poly(xs[1:], x)

def _orig_find_zero_spec(xs, root):
    if len(xs) % 2 != 0 or len(xs) == 0:
        return False
    if xs[-1] == 0:
        return False
    return poly(xs, root) == 0

def find_zero_spec(xs, output):
    return bool(_orig_find_zero_spec(xs, output))
