import math

def precondition(input):
    grid, capacity = input
    # grid must be a list of lists
    if not isinstance(grid, list):
        return False
    if len(grid) < 1 or len(grid) > 100:
        return False
    if not all(isinstance(row, list) for row in grid):
        return False
    # all rows must have the same length
    if len(grid) == 0:
        return False
    row_len = len(grid[0])
    if row_len < 1 or row_len > 100:
        return False
    for row in grid:
        if len(row) != row_len:
            return False
        for val in row:
            if val not in (0, 1):
                return False
    # capacity constraints
    if not isinstance(capacity, int):
        return False
    if capacity < 1 or capacity > 10:
        return False
    return True


def postcondition(input, output):
    grid, capacity = input
    # output must be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # compute expected: for each row, ceil(sum(row) / capacity), sum all
    import math
    expected = 0
    for row in grid:
        water = sum(row)
        if water > 0:
            expected += math.ceil(water / capacity)
    return output == expected

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
