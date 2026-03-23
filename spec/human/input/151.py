def _orig_problem_151_pre(l):
    return True

def _orig_problem_151_spec(l, output):
    acc = 0
    for h in l:
        if h >= 0 and h % 2 != 0:
            acc += h * h
    return output == acc

def problem_151_pre(lst):
    return bool(_orig_problem_151_pre(lst))

def problem_151_spec(lst, output):
    return bool(_orig_problem_151_spec(lst, output))
