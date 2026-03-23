def _orig_triples_sum_to_zero_spec(l, output):
    n = len(l)
    for i in range(n):
        for j in range(i + 1, n):
            for k in range(j + 1, n):
                if l[i] + l[j] + l[k] == 0:
                    return output == True
    return output == False

def triples_sum_to_zero_spec(l, output):
    return bool(_orig_triples_sum_to_zero_spec(l, output))
