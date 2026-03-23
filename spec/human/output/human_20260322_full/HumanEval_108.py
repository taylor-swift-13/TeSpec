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

def _impl(arr):
    def judge(x: int) -> int:
        l = list(str(x))
        if l[0] == "-":
            l = l[1:]
            l = list(map(int, l))
            l[0] = -l[0]
        else:
            l = list(map(int, l))
        return 1 if sum(l) > 0 else 0
    return sum(map(judge, arr))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_108_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_108_spec(*input, output))

def count_nums(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
