
def precondition(args) -> bool:
    lst, x = args
    
    # lst must be a list
    if not isinstance(lst, list):
        return False
    
    # Each element of lst must be a list (rows)
    for row in lst:
        if not isinstance(row, list):
            return False
    
    # x must be an integer
    if not isinstance(x, int):
        return False
    
    return True


def postcondition(args, output) -> bool:
    lst, x = args
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # Each element of output must be a tuple of two non-negative integers
    for item in output:
        if not isinstance(item, tuple):
            return False
        if len(item) != 2:
            return False
        row_idx, col_idx = item
        if not isinstance(row_idx, int) or not isinstance(col_idx, int):
            return False
        if row_idx < 0 or col_idx < 0:
            return False
    
    # Each coordinate must be valid and point to x in lst
    for row_idx, col_idx in output:
        if row_idx >= len(lst):
            return False
        if col_idx >= len(lst[row_idx]):
            return False
        if lst[row_idx][col_idx] != x:
            return False
    
    # All occurrences of x must be in output
    expected_coords = []
    for i, row in enumerate(lst):
        for j, val in enumerate(row):
            if val == x:
                expected_coords.append((i, j))
    
    if len(output) != len(expected_coords):
        return False
    
    # Check that output contains all expected coordinates
    if set(output) != set(expected_coords):
        return False
    
    # Check sorting: rows in ascending order, within same row columns in descending order
    for i in range(len(output) - 1):
        curr_row, curr_col = output[i]
        next_row, next_col = output[i + 1]
        
        if curr_row > next_row:
            return False
        if curr_row == next_row and curr_col <= next_col:
            return False
    
    return True

def _impl(lst, x):
    """You are given a 2 dimensional data, as a nested lists,
    which is similar to matrix, however, unlike matrices,
    each row may contain a different number of columns.
    Given lst, and integer x, find integers x in the list,
    and return list of tuples, [(x1, y1), (x2, y2) ...] such that
    each tuple is a coordinate - (row, columns), starting with 0.
    Sort coordinates initially by rows in ascending order.
    Also, sort coordinates of the row by columns in descending order.

    Examples:
    get_row([
      [1,2,3,4,5,6],
      [1,2,3,4,1,6],
      [1,2,3,4,5,1]
    ], 1) == [(0, 0), (1, 4), (1, 0), (2, 5), (2, 0)]
    get_row([], 1) == []
    get_row([[], [1], [1, 2, 3]], 3) == [(2, 2)]"""
    res = []
    for i, l in enumerate(lst):
        for j in range(len(l) - 1, -1, -1):
            if l[j] == x: res.append((i, j))
    return res

def get_row(lst, x):
    _input = (lst, x)
    assert precondition(_input)
    _output = _impl(lst, x)
    assert postcondition(_input, _output)
    return _output
