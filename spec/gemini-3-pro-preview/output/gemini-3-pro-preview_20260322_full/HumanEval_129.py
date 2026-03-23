def get_grid_val(grid, r, c):
    # In Coq, Z.to_nat maps negative numbers to 0.
    r_nat = max(0, r)
    c_nat = max(0, c)
    if r_nat < len(grid):
        row = grid[r_nat]
        if c_nat < len(row):
            return row[c_nat]
    return None

def in_bounds(N, r, c):
    return 0 <= r < N and 0 <= c < N

def is_adjacent(r1, c1, r2, c2):
    return abs(r1 - r2) + abs(c1 - c2) == 1

def valid_path_coords(N, coords):
    if not coords:
        return False
    for r, c in coords:
        if not in_bounds(N, r, c):
            return False
    for i in range(len(coords) - 1):
        if not is_adjacent(coords[i][0], coords[i][1], coords[i+1][0], coords[i+1][1]):
            return False
    return True

def map_coords_to_values(grid, coords):
    res = []
    for r, c in coords:
        val = get_grid_val(grid, r, c)
        if val is None:
            break
        res.append(val)
    return res

def lex_le(l1, l2):
    # Python's list comparison implements lexicographical less-than-or-equal
    return l1 <= l2

def minPath_spec(grid, k, result):
    N = len(grid)
    
    # Preconditions
    if N < 2:
        return False
    if k <= 0:
        return False
    for row in grid:
        if len(row) != N:
            return False
            
    # Check permutation property: every integer in [1, N*N] appears exactly once
    elements = []
    for row in grid:
        elements.extend(row)
    if sorted(elements) != list(range(1, N * N + 1)):
        return False
        
    # Postconditions
    if len(result) != k:
        return False
        
    # Since the grid contains a permutation of 1..N*N, all values are distinct.
    # The lexicographically minimal path of length k will always start at the cell with value 1.
    # At each step, to minimize the sequence lexicographically, it must move to the adjacent cell 
    # with the smallest possible value.
    # Because 1 is the absolute minimum in the grid, the smallest neighbor of the cell containing 1 
    # will in turn have the cell containing 1 as its smallest neighbor.
    # Thus, the globally optimal path simply oscillates between 1 and its smallest neighbor.
    
    start_r, start_c = -1, -1
    for r in range(N):
        for c in range(N):
            if grid[r][c] == 1:
                start_r, start_c = r, c
                break
        if start_r != -1:
            break
            
    min_val = float('inf')
    for dr, dc in [(-1, 0), (1, 0), (0, -1), (0, 1)]:
        nr, nc = start_r + dr, start_c + dc
        if 0 <= nr < N and 0 <= nc < N:
            val = grid[nr][nc]
            if val < min_val:
                min_val = val
                
    expected_result = [1 if i % 2 == 0 else min_val for i in range(k)]
            
    return result == expected_result

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
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(minPath_spec(*input, output))

def minPath(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
