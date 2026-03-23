def _orig_problem_100_pre(n: int) -> bool:
    return n > 0

def _orig_problem_100_spec(n: int, out: list) -> bool:
    if len(out) != n:
        return False
    for i in range(n):
        if out[i] != n + 2 * i:
            return False
    return True

def problem_100_pre(n):
    return bool(_orig_problem_100_pre(n))

def problem_100_spec(n, output):
    return bool(_orig_problem_100_spec(n, output))
