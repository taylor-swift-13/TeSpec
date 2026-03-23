def count(z, lst):
    res = 0
    for h in lst:
        if z == h:
            res += 1
    return res

def find_max_satisfying(lst, candidates, current_max):
    for h in candidates:
        if count(h, lst) >= h:
            current_max = max(h, current_max)
    return current_max

def search_impl(lst):
    if not lst:
        return -1
    candidates = lst
    max_val = find_max_satisfying(lst, candidates, -1)
    if max_val == -1:
        return -1
    else:
        return max_val

def _orig_problem_69_pre(lst):
    if not lst:
        return False
    for x in lst:
        if x <= 0:
            return False
    return True

def _orig_problem_69_spec(lst, y):
    return y == search_impl(lst)

def problem_69_pre(lst):
    return bool(_orig_problem_69_pre(lst))

def problem_69_spec(lst, output):
    return bool(_orig_problem_69_spec(lst, output))
