def pairs_sum_to_zero_spec(l, res):
    has_pair = False
    n = len(l)
    for i in range(n):
        for j in range(i + 1, n):
            if l[i] + l[j] == 0:
                has_pair = True
                break
        if has_pair:
            break
    return res == has_pair
