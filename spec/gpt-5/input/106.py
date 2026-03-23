def factorial(n: int) -> int:
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_upto(n: int) -> int:
    if n == 0:
        return 0
    return sum_upto(n - 1) + n

def f_spec(n: int, ans: list) -> bool:
    if len(ans) != n:
        return False
    for i in range(1, n + 1):
        expected = factorial(i) if i % 2 == 0 else sum_upto(i)
        if ans[i - 1] != expected:
            return False
    return True
