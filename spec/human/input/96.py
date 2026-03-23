def is_prime(n):
    if n < 2:
        return False
    if n == 2:
        return True
    if n % 2 == 0:
        return False
    d = 3
    while d * d <= n:
        if n % d == 0:
            return False
        d += 2
    return True

def _orig_problem_96_pre(n):
    return True

def _orig_problem_96_spec(n, output):
    expected = []
    for i in range(2, n):
        if is_prime(i):
            expected.append(i)
    return output == expected

def problem_96_pre(n):
    return bool(_orig_problem_96_pre(n))

def problem_96_spec(n, output):
    return bool(_orig_problem_96_spec(n, output))
