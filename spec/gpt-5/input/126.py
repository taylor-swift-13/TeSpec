from collections import Counter

def _orig_is_sorted_spec(lst, output):
    is_sorted = all((lst[i] <= lst[i + 1] for i in range(len(lst) - 1)))
    counts = Counter(lst)
    counts_ok = all((count <= 2 for count in counts.values()))
    return output == (is_sorted and counts_ok)

def is_sorted_spec(lst, output):
    return bool(_orig_is_sorted_spec(lst, output))
