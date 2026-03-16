
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    lst, x = input
    if not isinstance(lst, list):
        return False
    if not isinstance(x, int):
        return False
    for row in lst:
        if not isinstance(row, list):
            return False
        for el in row:
            if not isinstance(el, int):
                return False
    return True

def postcondition(input, output):
    # Postcondition only required when precondition holds
    if not precondition(input):
        return True
    lst, x = input
    # output must be a list of 2-int tuples
    if not isinstance(output, list):
        return False
    for t in output:
        if not isinstance(t, tuple):
            return False
        if len(t) != 2:
            return False
        r, c = t
        if not (isinstance(r, int) and isinstance(c, int)):
            return False
        # indices must be non-negative
        if r < 0 or c < 0:
            return False
        if r >= len(lst):
            return False
        if c >= len(lst[r]):
            return False
    # No duplicate coordinates
    if len(output) != len(set(output)):
        return False
    # Expected positions where value equals x
    expected = []
    for i, row in enumerate(lst):
        for j, el in enumerate(row):
            if el == x:
                expected.append((i, j))
    if set(output) != set(expected):
        return False
    # Check ordering: rows ascending; within same row columns descending
    for i in range(len(output) - 1):
        r1, c1 = output[i]
        r2, c2 = output[i + 1]
        if r1 > r2:
            return False
        if r1 == r2 and c1 < c2:
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
