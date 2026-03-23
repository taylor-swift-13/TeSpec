def in_bounds(grid, p):
    r, c = p
    if r < 0 or c < 0:
        return False
    if r < len(grid):
        row = grid[r]
        if c < len(row):
            return True
    return False

def neighbors(p):
    r, c = p
    # In Coq, subtraction on nat saturates at 0 (e.g., 0 - 1 = 0).
    # We replicate this behavior using max(0, ...).
    return [
        (r, c + 1),
        (r + 1, c),
        (r, max(0, c - 1)),
        (max(0, r - 1), c)
    ]

def get_val(grid, p):
    r, c = p
    if r < 0 or c < 0:
        return 0
    if r < len(grid):
        row = grid[r]
        if c < len(row):
            return row[c]
    return 0

def lex_le(l1, l2):
    for h1, h2 in zip(l1, l2):
        if h1 < h2:
            return True
        if h1 > h2:
            return False
    return len(l1) <= len(l2)

def extend_paths(grid, k, fuel, paths):
    while fuel > 0:
        if k <= 1:
            return paths
        ex = []
        for p in paths:
            if not p:
                continue
            q = p[0]
            for nb in neighbors(q):
                if in_bounds(grid, nb):
                    ex.append([nb] + p)
        paths = ex
        k -= 1
        fuel -= 1
    return paths

def get_path_values(grid, path):
    return [get_val(grid, p) for p in reversed(path)]

def best_by_lex(grid, candidates):
    best_rest = []
    # Process from right to left to match Coq's Fixpoint behavior
    for p in reversed(candidates):
        v = get_path_values(grid, p)
        if lex_le(v, best_rest):
            best_rest = v
    return best_rest

def build_row_starts(r, row, c):
    res = []
    for i in range(len(row)):
        res.append([(r, c + i)])
    return res

def build_starts(g, r):
    res = []
    for i, row in enumerate(g):
        res.extend(build_row_starts(r + i, row, 0))
    return res

def find_minimum_path_impl(grid, k):
    starts = build_starts(grid, 0)
    fuel = k * (len(grid) + 1)
    cand = extend_paths(grid, k, fuel, starts)
    return best_by_lex(grid, cand)

def problem_129_pre(grid, k):
    if k < 1:
        return False
    if not grid:
        return False
    for row in grid:
        if not row:
            return False
    return True

def problem_129_spec(grid, k, output):
    return output == find_minimum_path_impl(grid, k)

def _impl(grid, k):
    N = len(grid)
    x, y = 0, 0
    for i in range(N):
        for j in range(N):
            if grid[i][j] == 1:
                x, y = i, j
    mn = N * N
    if x > 0: mn = min(mn, grid[x - 1][y])
    if x < N - 1: mn = min(mn, grid[x + 1][y])
    if y > 0: mn = min(mn, grid[x][y - 1])
    if y < N - 1: mn = min(mn, grid[x][y + 1])
    return [1 if i % 2 == 0 else mn for i in range(k)]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_129_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_129_spec(*input, output))

def minPath(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
