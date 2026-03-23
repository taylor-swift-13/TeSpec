def transform_entry(idx, num):
    """
    Transforms an entry based on its index:
    - If idx % 3 == 0, returns num^2.
    - Else if idx % 4 == 0, returns num^3.
    - Otherwise, returns num.
    """
    if idx % 3 == 0:
        return num * num
    elif idx % 4 == 0:
        return num * num * num
    else:
        return num

def sum_squares_helper(lst, idx):
    """
    Recursively (implemented iteratively for efficiency) calculates the sum 
    of transformed entries of the list starting from a given index.
    """
    total = 0
    current_idx = idx
    for x in lst:
        total += transform_entry(current_idx, x)
        current_idx += 1
    return total

def sum_squares_spec(lst, result):
    """
    Checks if the provided result matches the sum_squares_helper 
    calculation starting from index 0.
    """
    return result == sum_squares_helper(lst, 0)

def _impl(lst):
    ans = 0
    for i, num in enumerate(lst):
        if i % 3 == 0:
            ans += num ** 2
        elif i % 4 == 0:
            ans += num ** 3
        else:
            ans += num
    return ans

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sum_squares_spec(*input, output))

def sum_squares(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
