
def precondition(input):
    try:
        lst, x = input
        # lst must be a list of lists
        if not isinstance(lst, list):
            return False
        for row in lst:
            if not isinstance(row, list):
                return False
        # x must be an integer
        if not isinstance(x, int):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        lst, x = input
        # output must be a list of tuples
        if not isinstance(output, list):
            return False
        for item in output:
            if not isinstance(item, tuple) or len(item) != 2:
                return False
            row, col = item
            if not isinstance(row, int) or not isinstance(col, int):
                return False
            # coordinates must be valid
            if row < 0 or row >= len(lst):
                return False
            if col < 0 or col >= len(lst[row]):
                return False
            # the element at that coordinate must equal x
            if lst[row][col] != x:
                return False

        # Every occurrence of x in lst must appear in output
        all_occurrences = []
        for i, row in enumerate(lst):
            for j, val in enumerate(row):
                if val == x:
                    all_occurrences.append((i, j))
        if len(output) != len(all_occurrences):
            return False
        # Check that output contains exactly the right set of coordinates
        if set(output) != set(all_occurrences):
            return False

        # Check sorting: rows in ascending order
        # Within same row, columns in descending order
        for k in range(1, len(output)):
            prev_row, prev_col = output[k - 1]
            cur_row, cur_col = output[k]
            if cur_row < prev_row:
                return False
            if cur_row == prev_row:
                if cur_col >= prev_col:
                    return False

        return True
    except Exception:
        return False

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
