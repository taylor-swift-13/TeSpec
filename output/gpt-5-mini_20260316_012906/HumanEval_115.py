import math

def precondition(input):
    # input is expected to be a tuple: (grid, capacity)
    if not isinstance(input, (tuple, list)) or len(input) != 2:
        return False
    grid, capacity = input[0], input[1]
    # grid must be a non-empty list of rows
    if not isinstance(grid, list):
        return False
    if not (1 <= len(grid) <= 100):
        return False
    # every row must be a list, same length, and length in [1,100]
    first_len = None
    for row in grid:
        if not isinstance(row, list):
            return False
        if not (1 <= len(row) <= 100):
            return False
        if first_len is None:
            first_len = len(row)
        elif len(row) != first_len:
            return False
        # each element must be 0 or 1 (booleans allowed as they equal 0/1)
        for v in row:
            if v not in (0, 1):
                return False
    # capacity must be integer in [1,10]
    if not isinstance(capacity, int):
        return False
    if not (1 <= capacity <= 10):
        return False
    return True

def postcondition(input, output):
    # only validate when precondition holds
    if not precondition(input):
        return False
    grid, capacity = input[0], input[1]
    # output must be an int and non-negative
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    # expected number of lowers = sum( ceil(count_ones_in_row / capacity) )
    expected = 0
    for row in grid:
        ones = 0
        for v in row:
            if v == 1:
                ones += 1
        expected += (ones + capacity - 1) // capacity
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
