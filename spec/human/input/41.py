def _orig_problem_41_pre(input: int) -> bool:
    return True

def _orig_problem_41_spec(input: int, output: int) -> bool:
    return output == input * input

def problem_41_pre(n):
    return bool(_orig_problem_41_pre(n))

def problem_41_spec(n, output):
    return bool(_orig_problem_41_spec(n, output))
