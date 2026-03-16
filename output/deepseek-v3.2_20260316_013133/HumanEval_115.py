import math

def precondition(input):
    grid, capacity = input
    if not isinstance(grid, list) or not isinstance(capacity, int):
        return False
    if not (1 <= capacity <= 10):
        return False
    if not (1 <= len(grid) <= 100):
        return False
    if len(grid) == 0:
        return False
    first_len = len(grid[0])
    if not (1 <= first_len <= 100):
        return False
    for row in grid:
        if not isinstance(row, list):
            return False
        if len(row) != first_len:
            return False
        for val in row:
            if val not in (0, 1):
                return False
    return True

def postcondition(input, output):
    grid, capacity = input
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    total_water = sum(sum(row) for row in grid)
    if capacity <= 0:
        return False
    min_buckets = (total_water + capacity - 1) // capacity if total_water > 0 else 0
    if output < min_buckets:
        return False
    max_buckets = total_water
    if output > max_buckets:
        return False
    return True

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
