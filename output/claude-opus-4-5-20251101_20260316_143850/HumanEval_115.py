import math

def precondition(args) -> bool:
    grid, capacity = args
    
    # Check grid is a list
    if not isinstance(grid, list):
        return False
    
    # Check grid is non-empty
    if len(grid) < 1 or len(grid) > 100:
        return False
    
    # Check each row is a list
    for row in grid:
        if not isinstance(row, list):
            return False
    
    # Check all rows have the same length
    if len(grid) > 0:
        row_length = len(grid[0])
        if row_length < 1 or row_length > 100:
            return False
        for row in grid:
            if len(row) != row_length:
                return False
    
    # Check all elements are 0 or 1
    for row in grid:
        for cell in row:
            if cell not in (0, 1):
                return False
    
    # Check capacity is valid
    if not isinstance(capacity, int):
        return False
    if capacity < 1 or capacity > 10:
        return False
    
    return True


def postcondition(args, output) -> bool:
    grid, capacity = args
    
    # Output should be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    
    # Calculate total water in all wells
    total_water = sum(sum(row) for row in grid)
    
    # If no water, output should be 0
    if total_water == 0:
        return output == 0
    
    # Output should be at least ceil(total_water / capacity) if we could combine all water
    # But since each well needs its own bucket lowerings, we need to sum per-row
    import math
    min_lowerings = sum(math.ceil(sum(row) / capacity) for row in grid)
    
    # Output should equal the minimum number of lowerings needed
    if output != min_lowerings:
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
