def fib4(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 0
    if n == 2:
        return 2
    if n == 3:
        return 0
    
    a, b, c, d = 0, 0, 2, 0
    for _ in range(4, n + 1):
        a, b, c, d = b, c, d, a + b + c + d
    return d

def _orig_problem_46_pre(input: int) -> bool:
    return True

def _orig_problem_46_spec(input: int, output: int) -> bool:
    return output == fib4(input)

def problem_46_pre(n):
    return bool(_orig_problem_46_pre(n))

def problem_46_spec(n, output):
    return bool(_orig_problem_46_spec(n, output))
