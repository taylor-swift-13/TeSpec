def factorial(k):
    res = 1
    for i in range(1, k + 1):
        res *= i
    return res

def sum_1_to_i(i):
    res = 0
    for j in range(1, i + 1):
        res += j
    return res

def _orig_f_spec(n, l):
    if len(l) != n:
        return False
    for i in range(1, n + 1):
        if i % 2 == 0:
            expected = factorial(i)
        else:
            expected = sum_1_to_i(i)
        if l[i - 1] != expected:
            return False
    return True

def f_spec(n, output):
    return bool(_orig_f_spec(n, output))
