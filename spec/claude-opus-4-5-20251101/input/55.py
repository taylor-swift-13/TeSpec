def fib_nat(n):
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        m = n - 1
        return fib_nat(m) + fib_nat(m - 1)

def fib_spec(n, result):
    return n >= 0 and result == fib_nat(n)
