def triples_sum_to_zero_spec(l, res):
    n = len(l)
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if l[i] + l[j] + l[k] == 0:
                    return res == True
    return res == False
