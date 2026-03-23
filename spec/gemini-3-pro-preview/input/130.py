def tri_elem(n: int) -> int:
    if n == 0:
        return 1
    elif n == 1:
        return 3
    else:
        p = n - 1
        q = p - 1
        if n % 2 == 0:
            return 1 + n // 2
        else:
            return tri_elem(p) + tri_elem(q) + (1 + (n + 1) // 2)

def tri_spec(n: int, l: list) -> bool:
    expected = [tri_elem(i) for i in range(n + 1)]
    return l == expected
