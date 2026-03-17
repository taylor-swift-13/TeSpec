import math

def precondition(input) -> bool:
    try:
        grid, capacity = input
        if not isinstance(capacity, int) or not (1 <= capacity <= 10):
            return False
        if not isinstance(grid, list) or not (1 <= len(grid) <= 100):
            return False
        if not all(isinstance(row, list) for row in grid):
            return False
        m = len(grid[0])
        if not (1 <= m <= 100):
            return False
        for row in grid:
            if len(row) != m:
                return False
            if not all(isinstance(x, int) and x in (0, 1) for x in row):
                return False
        return True
    except Exception:
        return False

def postcondition(input, output) -> bool:
    try:
        grid, capacity = input
        if not isinstance(output, int):
            return False
        expected = sum((sum(row) + capacity - 1) // capacity for row in grid)
        return output == expected
    except Exception:
        return False

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
