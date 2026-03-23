def is_odd_digit(d: int) -> bool:
    return d == 1 or d == 3 or d == 5 or d == 7 or d == 9

def all_digits_odd_list(l: list) -> bool:
    for h in l:
        if not is_odd_digit(h):
            return False
    return True

def nat_to_digits_fueled(n: int, fuel: int) -> list:
    if fuel == 0:
        return []
    if n == 0:
        return []
    return [n % 10] + nat_to_digits_fueled(n // 10, fuel - 1)

def nat_to_digits(n: int) -> list:
    return nat_to_digits_fueled(n, n)

def has_only_odd_digits(n: int) -> bool:
    return all_digits_odd_list(nat_to_digits(n))

def has_only_odd_digits_bool(n: int) -> bool:
    digits = nat_to_digits(n)
    for d in digits:
        if not (d == 1 or d == 3 or d == 5 or d == 7 or d == 9):
            return False
    return True

def filter_odd_digits(l: list) -> list:
    res = []
    for h in l:
        if has_only_odd_digits_bool(h):
            res.append(h)
    return res

def insert_sorted(x: int, l: list) -> list:
    res = []
    inserted = False
    for h in l:
        if not inserted and x <= h:
            res.append(x)
            inserted = True
        res.append(h)
    if not inserted:
        res.append(x)
    return res

def sort_list(l: list) -> list:
    res = []
    for h in reversed(l):
        res = insert_sorted(h, res)
    return res

def unique_digits_impl(x: list) -> list:
    return sort_list(filter_odd_digits(x))

def problem_104_pre(x: list) -> bool:
    return all(n > 0 for n in x)

def problem_104_spec(x: list, y: list) -> bool:
    return y == unique_digits_impl(x)
