def find_in_row_desc(row, x, row_idx, col_idx):
    res = []
    for i, val in enumerate(row):
        if val == x:
            res.append((row_idx, col_idx + i))
    res.reverse()
    return res

def get_row_helper(lst, x, row_idx):
    res = []
    for i, row in enumerate(lst):
        res.extend(find_in_row_desc(row, x, row_idx + i, 0))
    return res

def get_row_spec(lst, x, result):
    return result == get_row_helper(lst, x, 0)

def _impl(lst, x):
    res = []
    for i, l in enumerate(lst):
        for j in range(len(l) - 1, -1, -1):
            if l[j] == x: res.append((i, j))
    return res

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(get_row_spec(*input, output))

def get_row(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
