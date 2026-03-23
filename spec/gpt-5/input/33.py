def third_indices(l):
    return [i for i in range(len(l)) if i % 3 == 0]

def third_elems(l):
    indices = third_indices(l)
    return [l[i] for i in indices]

def _orig_sort_third_spec(l, l_prime):
    if len(l) != len(l_prime):
        return False
    s_prime = sorted(third_elems(l))
    for i in range(len(l)):
        if i % 3 != 0:
            if l_prime[i] != l[i]:
                return False
    indices = third_indices(l)
    for k in range(len(indices)):
        if l_prime[indices[k]] != s_prime[k]:
            return False
    return True

def sort_third_spec(l, output):
    return bool(_orig_sort_third_spec(l, output))
