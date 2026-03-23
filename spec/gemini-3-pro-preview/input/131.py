def digits_spec(n: int, res: int) -> bool:
    if n < 0:
        return False

    odds = [int(d) for d in str(n) if int(d) % 2 != 0]

    if not odds:
        expected_res = 0
    else:
        expected_res = 1
        for d in odds:
            expected_res *= d

    return res == expected_res
