
def precondition(args) -> bool:
    grid, k = args
    
    # Check grid is a list
    if not isinstance(grid, list):
        return False
    
    # Check grid is non-empty
    if len(grid) == 0:
        return False
    
    n = len(grid)
    
    # Check N >= 2
    if n < 2:
        return False
    
    # Check each row is a list of length N
    for row in grid:
        if not isinstance(row, list):
            return False
        if len(row) != n:
            return False
    
    # Check all cells contain integers
    for row in grid:
        for cell in row:
            if not isinstance(cell, int):
                return False
    
    # Check k is a positive integer
    if not isinstance(k, int):
        return False
    if k < 1:
        return False
    
    # Check every integer in [1, N*N] appears exactly once
    values = []
    for row in grid:
        for cell in row:
            values.append(cell)
    
    expected = set(range(1, n * n + 1))
    if set(values) != expected:
        return False
    if len(values) != len(expected):
        return False
    
    return True


def postcondition(args, output) -> bool:
    grid, k = args
    n = len(grid)
    
    # Check output is a list
    if not isinstance(output, list):
        return False
    
    # Check output has length k
    if len(output) != k:
        return False
    
    # Check all values in output are integers in valid range [1, N*N]
    for val in output:
        if not isinstance(val, int):
            return False
        if val < 1 or val > n * n:
            return False
    
    # Build a mapping from value to position
    value_to_pos = {}
    for i in range(n):
        for j in range(n):
            value_to_pos[grid[i][j]] = (i, j)
    
    # Check that the path is valid (consecutive cells share an edge)
    if k >= 1:
        # First cell must exist in grid (already checked by value range)
        if output[0] not in value_to_pos:
            return False
        
        for i in range(1, k):
            if output[i] not in value_to_pos:
                return False
            prev_pos = value_to_pos[output[i - 1]]
            curr_pos = value_to_pos[output[i]]
            # Check if they are neighbors (share an edge)
            r1, c1 = prev_pos
            r2, c2 = curr_pos
            if abs(r1 - r2) + abs(c1 - c2) != 1:
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
