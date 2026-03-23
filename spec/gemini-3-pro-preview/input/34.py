def unique_spec(l, res):
    is_sorted = all(res[i] <= res[i+1] for i in range(len(res) - 1))
    no_dup = len(res) == len(set(res))
    same_elements = set(res) == set(l)
    return is_sorted and no_dup and same_elements
