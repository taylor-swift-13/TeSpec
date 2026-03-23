def is_happy_spec(s: str, res: bool) -> bool:
    if len(s) < 3:
        expected = False
    else:
        expected = True
        for i in range(len(s) - 2):
            c1 = s[i]
            c2 = s[i + 1]
            c3 = s[i + 2]
            if c1 == c2 or c1 == c3 or c2 == c3:
                expected = False
                break
    return res == expected
