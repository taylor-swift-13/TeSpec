def _orig_derivative_spec(xs, ds):

    def nth(n, l, default):
        if 0 <= n < len(l):
            return l[n]
        return default
    if len(ds) != max(0, len(xs) - 1):
        return False
    for i in range(1, len(xs)):
        if nth(i, ds, 0) != nth(i, xs, 0) * i:
            return False
    return True

def derivative_spec(xs, output):
    return bool(_orig_derivative_spec(xs, output))
