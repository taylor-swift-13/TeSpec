def is_min_of_list(m, l):
    return (m in l) and all(m <= x for x in l)

def next_smallest_spec(lst, r):
    if r is None:
        if not lst:
            return True
        m = min(lst)
        return all(x == m for x in lst)
    else:
        if not lst:
            return False
        m = min(lst)
        return (r in lst) and (m < r) and all(r <= y for y in lst if m < y)
