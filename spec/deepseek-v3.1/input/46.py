# 旧版本把 n >= 4 全部误写成常量 2。
# def _orig_fib4_spec(n: int, output: int) -> bool:
#     ...

def fib4(n: int) -> int:
    if n == 0:
        return 0
    if n == 1:
        return 0
    if n == 2:
        return 2
    if n == 3:
        return 0
    a, b, c, d = 0, 0, 2, 0
    for _ in range(4, n + 1):
        a, b, c, d = b, c, d, a + b + c + d
    return d

def _orig_fib4_spec(n: int, output: int) -> bool:
    return output == fib4(n)

def fib4_spec(n, output):
    return bool(_orig_fib4_spec(n, output))
