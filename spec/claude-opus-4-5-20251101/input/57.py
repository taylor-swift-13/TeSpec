def is_increasing(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def is_decreasing(l):
    for i in range(len(l) - 1):
        if l[i] < l[i + 1]:
            return False
    return True

def _orig_monotonic_spec(l, output):
    return bool(output) == (is_increasing(l) or is_decreasing(l))

def monotonic_spec(l, output):
    return bool(_orig_monotonic_spec(l, output))
