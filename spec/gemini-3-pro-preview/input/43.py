def _orig_pairs_sum_to_zero_spec(l, output):
    has_pair = False
    n = len(l)
    for i in range(n):
        for j in range(i + 1, n):
            if l[i] + l[j] == 0:
                has_pair = True
                break
        if has_pair:
            break
    return output == has_pair

def pairs_sum_to_zero_spec(l, output):
    return bool(_orig_pairs_sum_to_zero_spec(l, output))
