def _orig_problem_57_pre(l):
    return True

def _orig_problem_57_spec(l, b):
    is_inc = all((l[i] <= l[i + 1] for i in range(len(l) - 1)))
    is_dec = all((l[i] >= l[i + 1] for i in range(len(l) - 1)))
    return b == (is_inc or is_dec)

def problem_57_pre(l):
    return bool(_orig_problem_57_pre(l))

def problem_57_spec(l, output):
    return bool(_orig_problem_57_spec(l, output))
