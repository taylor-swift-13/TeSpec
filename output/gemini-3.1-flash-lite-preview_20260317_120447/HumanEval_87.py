
def precondition(input):
    lst, x = input
    if not isinstance(lst, list):
        return False
    for row in lst:
        if not isinstance(row, list):
            return False
    return isinstance(x, int)

def postcondition(input, output):
    lst, x = input
    if not isinstance(output, list):
        return False
    
    expected = []
    for r_idx, row in enumerate(lst):
        row_matches = []
        for c_idx, val in enumerate(row):
            if val == x:
                row_matches.append((r_idx, c_idx))
        # Sort row matches by column descending
        row_matches.sort(key=lambda item: item[1], reverse=True)
        expected.extend(row_matches)
        
    return output == expected

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
