def count_diffs(l1, l2):
    res = 0
    for x, y in zip(l1, l2):
        if x != y:
            res += 1
    return res

def smallest_change_spec(arr, cnt):
    half_len = len(arr) // 2
    prefix = arr[:half_len]
    suffix_reversed = arr[::-1][:half_len]
    return cnt == count_diffs(prefix, suffix_reversed)
