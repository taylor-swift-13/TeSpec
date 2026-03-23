def get_indices_div_by_three(l, idx):
    res = []
    for x in l:
        if idx % 3 == 0:
            res.append(x)
        idx += 1
    return res

def nth_default(d, l, n):
    if n < len(l):
        return l[n]
    return d

def build_result(l, sorted_thirds, idx):
    res = []
    for x in l:
        if idx % 3 == 0:
            res.append(nth_default(0, sorted_thirds, idx // 3))
        else:
            res.append(x)
        idx += 1
    return res

def is_sorted(l):
    for i in range(len(l)):
        for j in range(i + 1, len(l)):
            if nth_default(0, l, i) > nth_default(0, l, j):
                return False
    return True

def _orig_sort_third_spec(l, l_prime):
    thirds = get_indices_div_by_three(l, 0)
    sorted_thirds = sorted(thirds)
    if len(l) != len(l_prime):
        return False
    for i in range(len(l)):
        if i % 3 == 0:
            if nth_default(0, l_prime, i) != nth_default(0, sorted_thirds, i // 3):
                return False
        elif nth_default(0, l_prime, i) != nth_default(0, l, i):
            return False
    return True

def sort_third_spec(l, output):
    return bool(_orig_sort_third_spec(l, output))
