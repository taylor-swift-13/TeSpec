def a_value(i):
    return i * i - i + 1

def is_valid_triple(n, i, j, k):
    return (1 <= i < j < k <= n) and ((a_value(i) + a_value(j) + a_value(k)) % 3 == 0)

def count_valid_triples(n):
    one_cnt = 1 + ((n - 2) // 3) * 2 + (n - 2) % 3
    zero_cnt = n - one_cnt
    return (one_cnt * (one_cnt - 1) * (one_cnt - 2)) // 6 + \
           (zero_cnt * (zero_cnt - 1) * (zero_cnt - 2)) // 6

def get_max_triples_spec(n, result):
    if n <= 2:
        return result == 0
    else:
        return result == count_valid_triples(n)
