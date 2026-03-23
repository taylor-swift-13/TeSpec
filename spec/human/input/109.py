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
