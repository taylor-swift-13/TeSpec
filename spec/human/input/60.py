def _orig_problem_60_pre(n: int) -> bool:
    return n > 0

def _orig_problem_60_spec(n: int, output: int) -> bool:
    return 2 * output == n * (n + 1)

def problem_60_pre(n):
    return bool(_orig_problem_60_pre(n))

def problem_60_spec(n, output):
    return bool(_orig_problem_60_spec(n, output))
