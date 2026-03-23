def drop_at(lst, k):
    if 1 <= k < len(lst):
        return lst[k] < lst[k - 1]
    return False

def _orig_problem_135_pre(lst):
    return len(lst) == len(set(lst))

def _orig_problem_135_spec(lst, r):
    max_k = -1
    for k in range(1, len(lst)):
        if drop_at(lst, k):
            max_k = k
    return r == max_k

def problem_135_pre(arr):
    return bool(_orig_problem_135_pre(arr))

def problem_135_spec(arr, output):
    return bool(_orig_problem_135_spec(arr, output))
