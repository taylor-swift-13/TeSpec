def _orig_problem_54_pre(s0: str, s1: str) -> bool:
    return True

def _orig_problem_54_spec(s0: str, s1: str, b: bool) -> bool:
    return b == (set(s0) == set(s1))

def problem_54_pre(s0, s1):
    return bool(_orig_problem_54_pre(s0, s1))

def problem_54_spec(s0, s1, output):
    return bool(_orig_problem_54_spec(s0, s1, output))
