def nth(n, l, d=0):
    if 0 <= n < len(l):
        return l[n]
    return d

def _orig_tri_spec(n, output):
    if n == 0:
        return output == [1]
    if n == 1:
        return output == [1, 3]
    ans = [1, 3]
    for i in range(2, n + 1):
        if i % 2 == 0:
            lhs = nth(i - 2, ans) + 1 + i // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False
        else:
            lhs = nth(i - 2, ans) + nth(i - 3, ans) + 1 + (i + 1) // 2
            rhs = nth(i - 1, ans)
            if lhs != rhs:
                return False
    return output == ans

def tri_spec(n, output):
    return bool(_orig_tri_spec(n, output))
