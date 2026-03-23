def add_sum(lst, is_odd_idx):
    total = 0
    for x in lst:
        if is_odd_idx and x % 2 == 0:
            total += x
        is_odd_idx = not is_odd_idx
    return total

def add_spec(lst, res):
    return res == add_sum(lst, False)
