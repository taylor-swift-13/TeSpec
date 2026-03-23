def is_odd_digit(d: int) -> bool:
    return d == 1 or d == 3 or d == 5 or d == 7 or d == 9

def all_digits_odd_list(l: list) -> bool:
    if not l:
        return True
    h = l[0]
    t = l[1:]
    return is_odd_digit(h) and all_digits_odd_list(t)

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
    return all(d == 1 or d == 3 or d == 5 or d == 7 or d == 9 for d in digits)

def filter_odd_digits(l: list) -> list:
    if not l:
        return []
    h = l[0]
    t = l[1:]
    if has_only_odd_digits_bool(h):
        return [h] + filter_odd_digits(t)
    else:
        return filter_odd_digits(t)

def insert_sorted(x: int, l: list) -> list:
    if not l:
        return [x]
    h = l[0]
    t = l[1:]
    if x <= h:
        return [x] + l
    else:
        return [h] + insert_sorted(x, t)

def sort_list(l: list) -> list:
    if not l:
        return []
    h = l[0]
    t = l[1:]
    return insert_sorted(h, sort_list(t))

def unique_digits_impl(x: list) -> list:
    return sort_list(filter_odd_digits(x))

def problem_104_pre(x: list) -> bool:
    return all(n > 0 for n in x)

def problem_104_spec(x: list, y: list) -> bool:
    return y == unique_digits_impl(x)

def _impl(x):
    def judge(x):
        for ch in str(x):
            if int(ch) % 2 == 0:
                return False
        return True
    return sorted(list(filter(judge, x)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_104_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_104_spec(*input, output))

def unique_digits(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
