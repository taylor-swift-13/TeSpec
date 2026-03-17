
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 2:
        return False
    lst, x = inputs
    if not isinstance(lst, list):
        return False
    return all(isinstance(row, list) for row in lst)

def postcondition(inputs: tuple, output) -> bool:
    lst, x = inputs
    if not isinstance(output, list):
        return False
    
    expected_count = 0
    for r, row in enumerate(lst):
        for c, val in enumerate(row):
            if val == x:
                expected_count += 1
                if (r, c) not in output:
                    return False
                    
    if len(output) != expected_count:
        return False
        
    for i in range(len(output) - 1):
        r1, c1 = output[i]
        r2, c2 = output[i+1]
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
