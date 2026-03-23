def sum_digits_pos_fuel(fuel: int, n: int) -> int:
    res = 0
    while fuel > 0:
        if n <= 0:
            break
        res += n % 10
        n = n // 10
        fuel -= 1
    return res

def msd_fuel(fuel: int, n: int) -> int:
    while fuel > 0:
        if n < 10:
            return n
        n = n // 10
        fuel -= 1
    return n % 10

def sum_digits(n: int) -> int:
    if n >= 0:
        return sum_digits_pos_fuel(n + 1, n)
    else:
        npos = -n
        tot = sum_digits_pos_fuel(npos + 1, npos)
        fd = msd_fuel(npos + 1, npos)
        return tot - 2 * fd

def le_stable(p1, p2) -> bool:
    z1, i1 = p1
    z2, i2 = p2
    s1 = sum_digits(z1)
    s2 = sum_digits(z2)
    return s1 < s2 or (s1 == s2 and i1 <= i2)

def insert_sorted(x, l):
    res = []
    for i, h in enumerate(l):
        zx, ix = x
        zh, ih = h
        sx = sum_digits(zx)
        sh = sum_digits(zh)
        if sx < sh:
            return res + [x] + l[i:]
        elif sx == sh:
            if ix <= ih:
                return res + [x] + l[i:]
            else:
                res.append(h)
        else:
            res.append(h)
    return res + [x]

def stable_sort(l):
    res = []
    for x in reversed(l):
        res = insert_sorted(x, res)
    return res

def order_by_points_impl(l_in):
    indexed = list(zip(l_in, range(len(l_in))))
    sorted_list = stable_sort(indexed)
    return [z for z, i in sorted_list]

def problem_145_pre(l_in) -> bool:
    return True

def problem_145_spec(l_in, output) -> bool:
    return output == order_by_points_impl(l_in)
