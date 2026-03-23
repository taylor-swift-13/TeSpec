# 旧版本把 n >= 4 的规格误判为不可满足。
# def _orig_fib4_spec(n: int, output: int) -> bool:
#     if n == 0:
#         return output == 0
#     if n == 1:
#         return output == 0
#     if n == 2:
#         return output == 2
#     if n == 3:
#         return output == 0
#     if n >= 4:
#         return False
#     return False

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
