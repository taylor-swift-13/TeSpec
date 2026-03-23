# 旧版本漏掉了 n >= 3 的递推。
# def _orig_fib_spec(n: int, fib_n: int) -> bool:
#     ...

def fib(n: int) -> int:
    if n == 0:
        return 0
    if n == 1 or n == 2:
        return 1
    a, b = 1, 1
    for _ in range(3, n + 1):
        a, b = b, a + b
    return b

def _orig_fib_spec(n: int, fib_n: int) -> bool:
    return fib_n == fib(n)

def fib_spec(n, output):
    return bool(_orig_fib_spec(n, output))
