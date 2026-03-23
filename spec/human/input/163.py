def _orig_problem_163_pre(a, b):
    return a > 0 and b > 0

def _orig_problem_163_spec(a, b, l):
    lower = min(a, b)
    upper = max(a, b)
    expected = []
    for d in range(lower, upper + 1):
        if d < 10 and d % 2 == 0:
            expected.append(d)
    return l == expected

def problem_163_pre(a, b):
    return bool(_orig_problem_163_pre(a, b))

def problem_163_spec(a, b, output):
    return bool(_orig_problem_163_spec(a, b, output))
