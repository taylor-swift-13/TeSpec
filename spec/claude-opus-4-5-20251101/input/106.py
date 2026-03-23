def factorial(n: int) -> int:
    if n == 0:
        return 1
    return n * factorial(n - 1)

def sum_1_to_n(n: int) -> int:
    if n == 0:
        return 0
    return n + sum_1_to_n(n - 1)

def f_element(i: int) -> int:
    if i % 2 == 0:
        return factorial(i)
    else:
        return sum_1_to_n(i)

def f_list(n: int) -> list:
    if n == 0:
        return []
    return f_list(n - 1) + [f_element(n)]

def f_spec(n: int, result: list) -> bool:
    if result != f_list(n):
        return False
    if len(result) != n:
        return False
    for i in range(1, n + 1):
        val = result[i - 1] if 0 <= i - 1 < len(result) else 0
        if val != f_element(i):
            return False
    return True
