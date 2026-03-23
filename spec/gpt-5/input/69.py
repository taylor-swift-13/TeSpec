def freq(z, l):
    return sum(1 for x in l if x == z)

def _orig_search_spec(lst, output):
    if not all((x > 0 for x in lst)):
        return False
    if not lst:
        return False
    valid_ns = [n for n in set(lst) if n > 0 and freq(n, lst) >= n]
    if valid_ns:
        return output == max(valid_ns)
    else:
        return output == -1

def search_spec(lst, output):
    return bool(_orig_search_spec(lst, output))
