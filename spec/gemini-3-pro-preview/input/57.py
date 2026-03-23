def sorted_inc(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def sorted_dec(l):
    for i in range(len(l) - 1):
        if l[i] < l[i + 1]:
            return False
    return True

def _orig_monotonic_spec(l, output):
    is_monotonic = sorted_inc(l) or sorted_dec(l)
    return output == is_monotonic

def monotonic_spec(l, output):
    return bool(_orig_monotonic_spec(l, output))
