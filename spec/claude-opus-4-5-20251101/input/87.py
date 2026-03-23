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
