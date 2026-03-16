
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    grid, k = input
    if not isinstance(grid, list) or len(grid) == 0:
        return False
    N = len(grid)
    if N < 2:
        return False
    for row in grid:
        if not isinstance(row, list) or len(row) != N:
            return False
        for v in row:
            if not isinstance(v, int):
                return False
    vals = [v for row in grid for v in row]
    if set(vals) != set(range(1, N * N + 1)):
        return False
    if not isinstance(k, int) or k < 1:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    grid, k = input
    if not isinstance(grid, list) or len(grid) == 0:
        return False
    N = len(grid)
    if N < 2:
        return False
    for row in grid:
        if not isinstance(row, list) or len(row) != N:
            return False
        for v in row:
            if not isinstance(v, int):
                return False
    vals = [v for row in grid for v in row]
    if set(vals) != set(range(1, N * N + 1)):
        return False
    if not isinstance(k, int) or k < 1:
        return False

    if not isinstance(output, list):
        return False
    if len(output) != k:
        return False
    if any(not isinstance(x, int) for x in output):
        return False
    if any(x < 1 or x > N * N for x in output):
        return False

    pos = {}
    for r in range(N):
        for c in range(N):
            pos[grid[r][c]] = (r, c)

    for i in range(1, k):
        v_prev = output[i - 1]
        v_cur = output[i]
        if v_cur == v_prev:
            return False
        r1, c1 = pos[v_prev]
        r2, c2 = pos[v_cur]
        if abs(r1 - r2) + abs(c1 - c2) != 1:
            return False

    def compute_minimal_path(grid_local, k_local):
        Nl = len(grid_local)
        pos_local = {grid_local[r][c]: (r, c) for r in range(Nl) for c in range(Nl)}
        path = []
        val = 1
        path.append(val)
        r, c = pos_local[val]
        for _ in range(1, k_local):
            neigh_vals = []
            for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
                nr, nc = r + dr, c + dc
                if 0 <= nr < Nl and 0 <= nc < Nl:
                    neigh_vals.append(grid_local[nr][nc])
            next_val = min(neigh_vals)
            path.append(next_val)
            r, c = pos_local[next_val]
        return path

    expected = compute_minimal_path(grid, k)
    if output != expected:
        return False

    return True

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
