def coord_order(c1, c2):
    if c1[0] < c2[0]:
        return True
    if c1[0] == c2[0] and c1[1] > c2[1]:
        return True
    return False

def is_sorted(l):
    if len(l) <= 1:
        return True
    for i in range(len(l) - 1):
        if not coord_order(l[i], l[i+1]):
            return False
    return True

def collect_coords_row(row, r, c, x):
    res = []
    for h in row:
        if h == x:
            res.append((r, c))
        c += 1
    return res

def collect_all_coords(lst, r, x):
    res = []
    for row in lst:
        res.extend(collect_coords_row(row, r, 0, x))
        r += 1
    return res

def insert_coord(coord, coords):
    res = []
    inserted = False
    for h in coords:
        if not inserted:
            if coord[0] < h[0]:
                res.append(coord)
                inserted = True
                res.append(h)
            elif coord[0] == h[0]:
                if h[1] < coord[1]:
                    res.append(coord)
                    inserted = True
                    res.append(h)
                else:
                    res.append(h)
            else:
                res.append(h)
        else:
            res.append(h)
    if not inserted:
        res.append(coord)
    return res

def sort_coords(coords):
    res = []
    for coord in reversed(coords):
        res = insert_coord(coord, res)
    return res

def get_row_impl(lst, x):
    return sort_coords(collect_all_coords(lst, 0, x))

def problem_87_pre(lst, x):
    return True

def problem_87_spec(lst, x, res):
    return res == get_row_impl(lst, x)

def _impl(lst, x):
    res = []
    for i, l in enumerate(lst):
        for j in range(len(l) - 1, -1, -1):
            if l[j] == x: res.append((i, j))
    return res

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_87_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_87_spec(*input, output))

def get_row(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
