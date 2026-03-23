def problem_60_pre(n: int) -> bool:
    return n > 0

def problem_60_spec(n: int, output: int) -> bool:
    return 2 * output == n * (n + 1)
