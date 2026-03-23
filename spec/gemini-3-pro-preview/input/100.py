def make_a_pile_spec(n: int, res: list) -> bool:
    expected = [n + 2 * i for i in range(max(0, n))]
    return res == expected
