def _orig_problem_126_pre(l):
    return True

def _orig_problem_126_spec(l, b):
    sorted_nat_lt = all((l[i] < l[i + 1] for i in range(len(l) - 1)))
    b_eq_true = b == True
    return sorted_nat_lt == b_eq_true

def problem_126_pre(lst):
    return bool(_orig_problem_126_pre(lst))

def problem_126_spec(lst, output):
    return bool(_orig_problem_126_spec(lst, output))
