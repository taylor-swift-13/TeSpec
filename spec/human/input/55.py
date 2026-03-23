def fib(n: int) -> int:
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n - 2) + fib(n - 1)

def _orig_problem_55_pre(n: int) -> bool:
    return True

def _orig_problem_55_spec(n: int, output: int) -> bool:
    return output == fib(n)

def problem_55_pre(n):
    return bool(_orig_problem_55_pre(n))

def problem_55_spec(n, output):
    return bool(_orig_problem_55_spec(n, output))
