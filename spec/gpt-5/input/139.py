def fact(n):
    res = 1
    for i in range(1, n + 1):
        res *= i
    return res

def brazilian_factorial(n):
    res = 1
    for i in range(1, n + 1):
        res *= fact(i)
    return res

def _orig_special_factorial_spec(n, output):
    return output == brazilian_factorial(n)

def special_factorial_spec(n, output):
    return bool(_orig_special_factorial_spec(n, output))
