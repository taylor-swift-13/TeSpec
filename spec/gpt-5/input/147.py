def get_max_triples_spec(n: int, ans: int) -> bool:
    if n <= 2:
        expected = 0
    else:
        one_cnt = 1 + 2 * ((n - 2) // 3) + ((n - 2) % 3)
        zero_cnt = n - one_cnt
        expected = (one_cnt * (one_cnt - 1) * (one_cnt - 2)) // 6 + \
                   (zero_cnt * (zero_cnt - 1) * (zero_cnt - 2)) // 6
    return ans == expected
