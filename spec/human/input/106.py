def _orig_problem_106_pre(n):
    return True

def _orig_problem_106_spec(n, l):

    def fact(x):
        res = 1
        for k in range(1, x + 1):
            res *= k
        return res

    def sum_nat(x):
        return x * (x + 1) // 2

    def even(x):
        return x % 2 == 0
    if len(l) != n:
        return False
    for i in range(1, n + 1):
        actual_value = l[i - 1]
        if even(i):
            expected_value = fact(i)
        else:
            expected_value = sum_nat(i)
        if actual_value != expected_value:
            return False
    return True

def problem_106_pre(n):
    return bool(_orig_problem_106_pre(n))

def problem_106_spec(n, output):
    return bool(_orig_problem_106_spec(n, output))
