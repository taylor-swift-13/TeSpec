def is_positive_even(e: int) -> bool:
    return e > 0 and e % 2 == 0

def _orig_problem_138_pre(n: int) -> bool:
    return True

def _orig_problem_138_spec(n: int, b: bool) -> bool:
    expected = n >= 8 and n % 2 == 0
    return b == expected

def problem_138_pre(n):
    return bool(_orig_problem_138_pre(n))

def problem_138_spec(n, output):
    return bool(_orig_problem_138_spec(n, output))
