def is_sorted_bool(l):
    for i in range(len(l) - 1):
        if l[i] > l[i + 1]:
            return False
    return True

def right_shift(l):
    if not l:
        return []
    return [l[-1]] + l[:-1]

def n_shifts(n, l):
    res = l
    for _ in range(n):
        res = right_shift(res)
    return res

def check_all_shifts(arr, n):
    for i in range(n + 1):
        if is_sorted_bool(n_shifts(i, arr)):
            return True
    return False

def move_one_ball_impl(arr):
    if not arr:
        return True
    return check_all_shifts(arr, len(arr))

def problem_109_pre(arr):
    return len(set(arr)) == len(arr)

def problem_109_spec(arr, result):
    return result == move_one_ball_impl(arr)

def _impl(arr):
    sorted_arr = sorted(arr)
    if arr == sorted_arr: return True
    for i in range(1, len(arr)):
        if arr[i:] + arr[:i] == sorted_arr:
            return True
    return False

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_109_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_109_spec(*input, output))

def move_one_ball(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
