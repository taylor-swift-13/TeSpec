def _orig_problem_97_pre(a, b):
    return True

def _orig_problem_97_spec(a, b, r):
    return r == abs(a) % 10 * (abs(b) % 10)

def problem_97_pre(a, b):
    return bool(_orig_problem_97_pre(a, b))

def problem_97_spec(a, b, output):
    return bool(_orig_problem_97_spec(a, b, output))
