def three_consecutive_distinct(s, i):
    if i < 0 or i + 2 >= len(s):
        return False
    c1 = s[i]
    c2 = s[i + 1]
    c3 = s[i + 2]
    return c1 != c2 and c1 != c3 and c2 != c3

def _orig_is_happy_spec(s, output):
    if len(s) < 3:
        expected = False
    else:
        expected = True
        for i in range(len(s) - 2):
            if not three_consecutive_distinct(s, i):
                expected = False
                break
    return expected == output

def is_happy_spec(s, output):
    return bool(_orig_is_happy_spec(s, output))
