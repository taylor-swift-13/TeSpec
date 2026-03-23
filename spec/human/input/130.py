def tri(n: int) -> int:
    if n == 0:
        return 1
    elif n == 1:
        return 3
    else:
        if n % 2 == 0:
            return 1 + n // 2
        else:
            t_prev = 1 + (n - 1) // 2
            t_next = 1 + (n + 1) // 2
            return t_prev + tri(n - 2) + t_next

def problem_130_pre(n: int) -> bool:
    return True

def problem_130_spec(n: int, l: list) -> bool:
    if len(l) != n + 1:
        return False
    for i in range(n + 1):
        if l[i] != tri(i):
            return False
    return True
