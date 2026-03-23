def fact(n):
    if n == 0:
        return 1
    return n * fact(n - 1)

def brazilian_factorial(n):
    if n == 0:
        return 1
    return fact(n) * brazilian_factorial(n - 1)

def special_factorial_spec(n, ans):
    return ans == brazilian_factorial(n)
