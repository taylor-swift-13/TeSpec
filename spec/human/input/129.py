import sys

sys.setrecursionlimit(5000)

def nth_error(lst, n):
    if n < 0 or n >= len(lst):
        return None
    return lst[n]

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
    # Coq's nat subtraction saturates at 0.
    # We use max(0, ...) to replicate this behavior.
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
    i = 0
    len1 = len(l1)
    len2 = len(l2)
    while i < len1 and i < len2:
        if l1[i] < l2[i]:
            return True
        if l1[i] > l2[i]:
            return False
        i += 1
    # If l1 is exhausted, it matches the first case ([], _) => true
    if i == len1:
        return True
    # If l1 is not exhausted but l2 is, it matches the second case (_::_, []) => false
    return False

def fold_right(f, lst, acc):
    # Iterative fold_right to match Coq's fold_right behavior
    res = acc
    for x in reversed(lst):
        res = f(x, res)
    return res

def extend_paths(grid, k, fuel, paths):
    while fuel > 0:
        if k <= 1:
            return paths
        
        def process_path(p, acc):
            if not p:
                return acc
            q = p[0]
            
            def process_neighbor(nb, acc2):
                if in_bounds(grid, nb):
                    return [[nb] + p] + acc2
                return acc2
            
            return fold_right(process_neighbor, neighbors(q), acc)
            
        ex = fold_right(process_path, paths, [])
        
        paths = ex
        k -= 1
        fuel -= 1
    return paths

def get_path_values(grid, path):
    return [get_val(grid, p) for p in reversed(path)]

def best_by_lex(grid, candidates):
    # Coq's best_by_lex uses recursion:
    # match candidates with
    # | [] => []
    # | p::ps => if lex_le v (best_by_lex ps) then v else (best_by_lex ps)
    #
    # This implementation faithfully reproduces the behavior of the Coq spec,
    # including the fact that it returns [] for non-empty paths because
    # lex_le(v, []) is False for non-empty v.
    
    best_rest = []
    for p in reversed(candidates):
        v = get_path_values(grid, p)
        if lex_le(v, best_rest):
            best_rest = v
        # else keep best_rest
            
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

def _orig_problem_129_pre(grid, k):
    if k < 1:
        return False
    if not grid:
        return False
    for row in grid:
        if not row:
            return False
    return True

def _orig_problem_129_spec(grid, k, output):
    return output == find_minimum_path_impl(grid, k)

def problem_129_pre(grid, k):
    return bool(_orig_problem_129_pre(grid, k))

def problem_129_spec(grid, k, output):
    return bool(_orig_problem_129_spec(grid, k, output))
