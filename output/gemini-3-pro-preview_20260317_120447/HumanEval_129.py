
def precondition(input_args) -> bool:
    if not isinstance(input_args, tuple) or len(input_args) != 2:
        return False
    grid, k = input_args
    if not isinstance(k, int) or k < 1:
        return False
    if not isinstance(grid, list) or not grid:
        return False
    n = len(grid)
    if n < 2:
        return False
    all_values = set()
    for row in grid:
        if not isinstance(row, list) or len(row) != n:
            return False
        for val in row:
            if not isinstance(val, int):
                return False
            all_values.add(val)
    
    expected_values = set(range(1, n * n + 1))
    return all_values == expected_values

def postcondition(input_args, output) -> bool:
    grid, k = input_args
    if not isinstance(output, list) or len(output) != k:
        return False
    
    n = len(grid)
    val_to_pos = {}
    for r in range(n):
        for c in range(n):
            val_to_pos[grid[r][c]] = (r, c)
            
    for i in range(len(output)):
        if output[i] not in val_to_pos:
            return False
        if i > 0:
            r1, c1 = val_to_pos[output[i-1]]
            r2, c2 = val_to_pos[output[i]]
            dist = abs(r1 - r2) + abs(c1 - c2)
            if dist != 1:
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
