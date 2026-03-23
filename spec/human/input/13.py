import math

def _orig_problem_13_pre(a: int, b: int) -> bool:
    return a != 0 or b != 0

def _orig_problem_13_spec(a: int, b: int, output: int) -> bool:
    return output == math.gcd(a, b)

def problem_13_pre(a, b):
    return bool(_orig_problem_13_pre(a, b))

def problem_13_spec(a, b, output):
    return bool(_orig_problem_13_spec(a, b, output))
