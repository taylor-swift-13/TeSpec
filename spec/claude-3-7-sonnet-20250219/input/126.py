def no_more_than_two_duplicates(lst):
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
        if counts[x] > 2:
            return False
    return True

def ascending_sorted(lst):
    for i in range(len(lst) - 1):
        if lst[i] > lst[i + 1]:
            return False
    return True

def _orig_is_sorted_spec(lst, b):
    is_valid = no_more_than_two_duplicates(lst) and ascending_sorted(lst)
    return b == is_valid

def is_sorted_spec(lst, output):
    return bool(_orig_is_sorted_spec(lst, output))
