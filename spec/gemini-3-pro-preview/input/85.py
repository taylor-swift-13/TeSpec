def add_sum(lst, is_odd_idx):
    total = 0
    for x in lst:
        if is_odd_idx and x % 2 == 0:
            total += x
        is_odd_idx = not is_odd_idx
    return total

def _orig_add_spec(lst, output):
    return output == add_sum(lst, False)

def add_spec(lst, output):
    return bool(_orig_add_spec(lst, output))
