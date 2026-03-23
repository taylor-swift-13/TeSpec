def _orig_is_sorted_spec(lst, output):
    is_sorted = all((lst[i] <= lst[i + 1] for i in range(len(lst) - 1)))
    all_le_2 = True
    counts = {}
    for x in lst:
        counts[x] = counts.get(x, 0) + 1
        if counts[x] > 2:
            all_le_2 = False
            break
    expected = is_sorted and all_le_2
    return bool(output) == expected

def is_sorted_spec(lst, output):
    return bool(_orig_is_sorted_spec(lst, output))
