import sys
sys.setrecursionlimit(10000)

def coord_order(c1, c2):
    if c1[0] < c2[0]:
        return True
    if c1[0] == c2[0] and c1[1] > c2[1]:
        return True
    return False

def is_sorted(l):
    if len(l) <= 1:
        return True
    return coord_order(l[0], l[1]) and is_sorted(l[1:])

def collect_coords_row(row, r, c, x):
    if not row:
        return []
    h = row[0]
    t = row[1:]
    if h == x:
        return [(r, c)] + collect_coords_row(t, r, c + 1, x)
    else:
        return collect_coords_row(t, r, c + 1, x)

def collect_all_coords(lst, r, x):
    if not lst:
        return []
    row = lst[0]
    rest = lst[1:]
    return collect_coords_row(row, r, 0, x) + collect_all_coords(rest, r + 1, x)

def insert_coord(coord, coords):
    if not coords:
        return [coord]
    h = coords[0]
    t = coords[1:]
    if coord[0] < h[0]:
        return [coord] + coords
    elif coord[0] == h[0]:
        if h[1] < coord[1]:
            return [coord] + coords
        else:
            return [h] + insert_coord(coord, t)
    else:
        return [h] + insert_coord(coord, t)

def sort_coords(coords):
    if not coords:
        return []
    h = coords[0]
    t = coords[1:]
    return insert_coord(h, sort_coords(t))

def get_row_impl(lst, x):
    return sort_coords(collect_all_coords(lst, 0, x))

def problem_87_pre(lst, x):
    return True

def problem_87_spec(lst, x, res):
    return res == get_row_impl(lst, x)
