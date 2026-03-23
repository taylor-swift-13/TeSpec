def nth(n, l, d=0):
    if 0 <= n < len(l):
        return l[n]
    return d

# 旧版本只验证递推关系，没有真正构造完整输出列表。
# def _orig_tri_spec(n, output):
#     ...

def tri(n: int) -> int:
    if n == 0:
        return 1
    if n == 1:
        return 3
    if n % 2 == 0:
        return 1 + n // 2
    t_prev = 1 + (n - 1) // 2
    t_next = 1 + (n + 1) // 2
    return t_prev + tri(n - 2) + t_next

def _orig_tri_spec(n, output):
    if len(output) != n + 1:
        return False
    for i in range(n + 1):
        if output[i] != tri(i):
            return False
    return True

def tri_spec(n, output):
    return bool(_orig_tri_spec(n, output))
