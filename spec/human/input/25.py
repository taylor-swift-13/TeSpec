def IsPrime(n: int) -> bool:
    if n <= 1:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def _orig_problem_25_pre(input: int) -> bool:
    return True

def _orig_problem_25_spec(input: int, output: list) -> bool:
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    prod = 1
    for x in output:
        prod *= x
    if prod != input:
        return False
    for x in output:
        if not IsPrime(x):
            return False
    return True

def problem_25_pre(n):
    return bool(_orig_problem_25_pre(n))

def problem_25_spec(n, output):
    return bool(_orig_problem_25_spec(n, output))
