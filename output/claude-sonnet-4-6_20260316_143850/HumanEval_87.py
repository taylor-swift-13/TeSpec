
def precondition(args):
    if len(args) != 2:
        return False
    lst, x = args
    if not isinstance(lst, list):
        return False
    for row in lst:
        if not isinstance(row, list):
            return False
        for item in row:
            if not isinstance(item, (int, float)):
                return False
    return True


def postcondition(args, output):
    lst, x = args
    if not isinstance(output, list):
        return False
    for item in output:
        if not isinstance(item, tuple) or len(item) != 2:
            return False
        row, col = item
        if not isinstance(row, int) or not isinstance(col, int):
            return False
        if row < 0 or row >= len(lst):
            return False
        if col < 0 or col >= len(lst[row]):
            return False
        if lst[row][col] != x:
            return False
    # Check all occurrences are included
    expected_count = sum(1 for r, row in enumerate(lst) for c, val in enumerate(row) if val == x)
    if len(output) != expected_count:
        return False
    # Check sorted by rows ascending
    rows = [item[0] for item in output]
    if rows != sorted(rows):
        return False
    # Check within each row, columns are sorted descending
    from itertools import groupby
    for row_idx, group in groupby(output, key=lambda t: t[0]):
        cols = [t[1] for t in group]
        if cols != sorted(cols, reverse=True):
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
