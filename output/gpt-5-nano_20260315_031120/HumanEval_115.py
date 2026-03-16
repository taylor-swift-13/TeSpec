import math

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    grid, capacity = input
    if not isinstance(grid, list) or not isinstance(capacity, int):
        return False
    if capacity < 1 or capacity > 10:
        return False
    nrows = len(grid)
    if nrows < 1 or nrows > 100:
        return False
    row_len = None
    for row in grid:
        if not isinstance(row, list):
            return False
        if row_len is None:
            row_len = len(row)
            if row_len < 1 or row_len > 100:
                return False
        else:
            if len(row) != row_len:
                return False
        for v in row:
            if v not in (0, 1):
                return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    grid, capacity = input
    if not isinstance(grid, list) or not isinstance(capacity, int):
        return False
    if capacity < 1 or capacity > 10:
        return False
    if len(grid) < 1 or len(grid) > 100:
        return False
    row_len = None
    for row in grid:
        if not isinstance(row, list):
            return False
        if row_len is None:
            row_len = len(row)
            if row_len < 1 or row_len > 100:
                return False
        else:
            if len(row) != row_len:
                return False
        for v in row:
            if v not in (0, 1):
                return False
    expected = 0
    for row in grid:
        expected += (sum(row) + capacity - 1) // capacity
    return isinstance(output, int) and output == expected

def _impl(grid, capacity):
    """You are given a rectangular grid of wells. Each row represents a single well,
    and each 1 in a row represents a single unit of water.
    Each well has a corresponding bucket that can be used to extract water from it, 
    and all buckets have the same capacity.
    Your task is to use the buckets to empty the wells.
    Output the number of times you need to lower the buckets.

    Example 1:
        Input: 
            grid : [[0,0,1,0], [0,1,0,0], [1,1,1,1]]
            bucket_capacity : 1
        Output: 6

    Example 2:
        Input: 
            grid : [[0,0,1,1], [0,0,0,0], [1,1,1,1], [0,1,1,1]]
            bucket_capacity : 2
        Output: 5

    Example 3:
        Input: 
            grid : [[0,0,0], [0,0,0]]
            bucket_capacity : 5
        Output: 0

    Constraints:
        * all wells have the same length
        * 1 <= grid.length <= 10^2
        * 1 <= grid[:,1].length <= 10^2
        * grid[i][j] -> 0 | 1
        * 1 <= capacity <= 10"""
    ans = 0    
    for l in grid:
        ans += math.ceil(sum(l) / capacity)
    return ans

def max_fill(grid, capacity):
    _input = (grid, capacity)
    assert precondition(_input)
    _output = _impl(grid, capacity)
    assert postcondition(_input, _output)
    return _output
