def elem(i):
    return i * i - i + 1

def valid_triple(n, i, j, k):
    return (1 <= i and i < j and j < k and k <= n and 
            (elem(i) + elem(j) + elem(k)) % 3 == 0)

def _orig_get_max_triples_spec(n, output):
    if n < 3:
        expected = 0
    else:
        count_zeros = n // 3
        if n % 3 == 2:
            count_zeros += 1
        count_ones = n - count_zeros

        def nC3(x):
            if x < 3:
                return 0
            return x * (x - 1) * (x - 2) // 6
        expected = nC3(count_zeros) + nC3(count_ones)
    return output == expected

def get_max_triples_spec(n, output):
    return bool(_orig_get_max_triples_spec(n, output))
