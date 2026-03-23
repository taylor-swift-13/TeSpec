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

def get_row_spec(lst, x, res):
    expected = []
    for i, r in enumerate(lst):
        for j, v in enumerate(r):
            if v == x:
                expected.append((i, j))
    
    # Sort expected according to pair_order: row ascending, col descending
    expected.sort(key=lambda p: (p[0], -p[1]))
    
    return res == expected

def _impl(lst, x):
    res = []
    for i, l in enumerate(lst):
        for j in range(len(l) - 1, -1, -1):
            if l[j] == x: res.append((i, j))
    return res

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_row_spec(*input, output))

def get_row(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
