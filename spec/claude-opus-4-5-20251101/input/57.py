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

def monotonic_spec(l, result):
    return bool(result) == (is_increasing(l) or is_decreasing(l))
