def nat_sum_digits_aux(n: int, fuel: int) -> int:
    res = 0
    while fuel > 0 and n > 0:
        res += n % 10
        n //= 10
        fuel -= 1
    return res

def nat_get_msd_aux(m: int, fuel: int) -> int:
    while fuel > 0 and m >= 10:
        m //= 10
        fuel -= 1
    return m

def nat_sum_digits(n: int) -> int:
    return nat_sum_digits_aux(n, n)

def nat_get_msd(n: int) -> int:
    return nat_get_msd_aux(n, n)

def sum_digits(z: int) -> int:
    if z > 0:
        return nat_sum_digits(z)
    elif z == 0:
        return 0
    else:
        p = -z
        return nat_sum_digits(p) - 2 * nat_get_msd(p)

def count_nums_impl(l: list) -> int:
    return sum(1 for z in l if sum_digits(z) > 0)

def problem_108_pre(l: list) -> bool:
    return True

def problem_108_spec(l: list, output: int) -> bool:
    return output == count_nums_impl(l)
