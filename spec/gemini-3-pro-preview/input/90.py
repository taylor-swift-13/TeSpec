def _orig_next_smallest_spec(lst, output):
    if output is None:
        return len(set(lst)) <= 1
    else:
        z = output
        if z not in lst:
            return False
        if not lst:
            return False
        m = min(lst)
        if not m < z:
            return False
        for x in lst:
            if m < x:
                if not z <= x:
                    return False
        return True

def next_smallest_spec(lst, output):
    return bool(_orig_next_smallest_spec(lst, output))
