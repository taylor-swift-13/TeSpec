def problem_54_pre(s0: str, s1: str) -> bool:
    return True

def problem_54_spec(s0: str, s1: str, b: bool) -> bool:
    return b == (set(s0) == set(s1))
