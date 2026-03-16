
def precondition(input):
    if not isinstance(input, (list, tuple)):
        return False
    if len(input) != 2:
        return False
    grid, k = input[0], input[1]
    # check k
    if not isinstance(k, int):
        return False
    if k <= 0:
        return False
    # check grid type and shape
    if not isinstance(grid, (list, tuple)):
        return False
    N = len(grid)
    if N < 2:
        return False
    for row in grid:
        if not isinstance(row, (list, tuple)):
            return False
        if len(row) != N:
            return False
        for v in row:
            if not isinstance(v, int):
                return False
    # check values are exactly 1..N*N
    vals = []
    for row in grid:
        vals.extend(row)
    if len(vals) != N * N:
        return False
    s = set(vals)
    if s != set(range(1, N * N + 1)):
        return False
    return True

def postcondition(input, output):
    # basic input checks
    if not isinstance(input, (list, tuple)) or len(input) != 2:
        return False
    grid, k = input[0], input[1]
    if not isinstance(k, int) or k <= 0:
        return False
    if not isinstance(grid, (list, tuple)):
        return False
    N = len(grid)
    if N < 2:
        return False
    for row in grid:
        if not isinstance(row, (list, tuple)) or len(row) != N:
            return False
        for v in row:
            if not isinstance(v, int):
                return False
    # output should be sequence of length k of ints
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != k:
        return False
    for v in output:
        if not isinstance(v, int):
            return False
        if v < 1 or v > N * N:
            return False
    # build dp: dp_prev[r][c] is minimal tuple sequence of length t ending at (r,c)
    # initialize
    dp_prev = [[None for _ in range(N)] for __ in range(N)]
    for r in range(N):
        for c in range(N):
            dp_prev[r][c] = (grid[r][c],)
    # neighbor offsets
    neigh = [(1,0),(-1,0),(0,1),(0,-1)]
    for t in range(2, k+1):
        dp_cur = [[None for _ in range(N)] for __ in range(N)]
        for r in range(N):
            for c in range(N):
                best = None
                # previous step must be at a neighbor of (r,c)
                for dr, dc in neigh:
                    pr, pc = r + dr, c + dc
                    if 0 <= pr < N and 0 <= pc < N:
                        prev_seq = dp_prev[pr][pc]
                        if prev_seq is None:
                            continue
                        cand = prev_seq + (grid[r][c],)
                        if best is None or cand < best:
                            best = cand
                dp_cur[r][c] = best
        dp_prev = dp_cur
    # find overall best among dp_prev
    best_overall = None
    for r in range(N):
        for c in range(N):
            seq = dp_prev[r][c]
            if seq is None:
                continue
            if best_overall is None or seq < best_overall:
                best_overall = seq
    if best_overall is None:
        return False
    # compare to output
    out_tuple = tuple(output)
    return out_tuple == best_overall

def _impl(grid, k):
    """Given a grid with N rows and N columns (N >= 2) and a positive integer k, 
    each cell of the grid contains a value. Every integer in the range [1, N * N]
    inclusive appears exactly once on the cells of the grid.

    You have to find the minimum path of length k in the grid. You can start
    from any cell, and in each step you can move to any of the neighbor cells,
    in other words, you can go to cells which share an edge with you current
    cell.
    Please note that a path of length k means visiting exactly k cells (not
    necessarily distinct).
    You CANNOT go off the grid.
    A path A (of length k) is considered less than a path B (of length k) if
    after making the ordered lists of the values on the cells that A and B go
    through (let's call them lst_A and lst_B), lst_A is lexicographically less
    than lst_B, in other words, there exist an integer index i (1 <= i <= k)
    such that lst_A[i] < lst_B[i] and for any j (1 <= j < i) we have
    lst_A[j] = lst_B[j].
    It is guaranteed that the answer is unique.
    Return an ordered list of the values on the cells that the minimum path go through.

    Examples:

        Input: grid = [ [1,2,3], [4,5,6], [7,8,9]], k = 3
        Output: [1, 2, 1]

        Input: grid = [ [5,9,3], [4,1,6], [7,8,2]], k = 1
        Output: [1]"""
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

def minPath(grid, k):
    _input = (grid, k)
    assert precondition(_input)
    _output = _impl(grid, k)
    assert postcondition(_input, _output)
    return _output
