
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    lst, x = input
    if not isinstance(lst, list) or not isinstance(x, int):
        return False
    for row in lst:
        if not isinstance(row, list):
            return False
        for val in row:
            if not isinstance(val, int):
                return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    lst, x = input
    if not isinstance(lst, list) or not isinstance(x, int):
        return False
    if not isinstance(output, list):
        return False

    seen = set()
    for coord in output:
        if not isinstance(coord, tuple) or len(coord) != 2:
            return False
        r, c = coord
        if not isinstance(r, int) or not isinstance(c, int):
            return False
        if r < 0 or c < 0:
            return False
        if r >= len(lst):
            return False
        if c >= len(lst[r]):
            return False
        if lst[r][c] != x:
            return False
        if coord in seen:
            return False
        seen.add(coord)

    for i in range(1, len(output)):
        prev_r, prev_c = output[i-1]
        cur_r, cur_c = output[i]
        if cur_r < prev_r:
            return False
        if cur_r == prev_r and cur_c > prev_c:
            return False

    return True

def _impl(lst, x):
    """
    You are given a 2 dimensional data, as a nested lists,
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
    get_row([[], [1], [1, 2, 3]], 3) == [(2, 2)]
    """
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
