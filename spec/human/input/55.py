def fib(n: int) -> int:
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib(n - 2) + fib(n - 1)

def problem_55_pre(n: int) -> bool:
    return True

def problem_55_spec(n: int, res: int) -> bool:
    return res == fib(n)
