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

def special_factorial_spec(n, ans):
    return ans == brazilian_factorial(n)
