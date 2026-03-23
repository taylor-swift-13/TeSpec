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

def monotonic_spec(l, res):
    is_monotonic = sorted_inc(l) or sorted_dec(l)
    return res == is_monotonic
