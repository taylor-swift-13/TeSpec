def row(p):
    return p[0]

def col(p):
    return p[1]

def pair_order(p1, p2):
    return row(p1) < row(p2) or (row(p1) == row(p2) and col(p1) > col(p2))

def match_pos(lst, x, i, j):
    if 0 <= i < len(lst):
        r = lst[i]
        if 0 <= j < len(r):
            return r[j] == x
    return False

def _orig_get_row_spec(lst, x, output):
    expected = []
    for (i, r) in enumerate(lst):
        for (j, v) in enumerate(r):
            if v == x:
                expected.append((i, j))
    expected.sort(key=lambda p: (p[0], -p[1]))
    return output == expected

def get_row_spec(lst, x, output):
    return bool(_orig_get_row_spec(lst, x, output))
