def fib_nat(n):
    if n <= 0:
        return 0
    elif n == 1:
        return 1
    else:
        m = n - 1
        return fib_nat(m) + fib_nat(m - 1)

def _orig_fib_spec(n, output):
    return n >= 0 and output == fib_nat(n)

def fib_spec(n, output):
    return bool(_orig_fib_spec(n, output))
