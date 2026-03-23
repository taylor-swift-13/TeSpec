def adj_le(l):
    for i in range(len(l) - 1):
        if not (l[i] <= l[i + 1]):
            return False
    return True

def adj_ge(l):
    for i in range(len(l) - 1):
        if not (l[i] >= l[i + 1]):
            return False
    return True

def _orig_monotonic_spec(l, output):
    is_monotonic = adj_le(l) or adj_ge(l)
    return output == is_monotonic

def monotonic_spec(l, output):
    return bool(_orig_monotonic_spec(l, output))
