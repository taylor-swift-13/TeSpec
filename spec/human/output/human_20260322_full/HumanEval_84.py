def sum_decimal_digits_aux(fuel: int, n: int) -> int:
    if fuel == 0:
        return 0
    if n == 0:
        return 0
    return (n % 10) + sum_decimal_digits_aux(fuel - 1, n // 10)

def sum_decimal_digits(n: int) -> int:
    return sum_decimal_digits_aux(n, n)

def nat_to_binary_string_pos_aux(fuel: int, n: int) -> str:
    if fuel == 0:
        return ""
    if n == 0:
        return ""
    return nat_to_binary_string_pos_aux(fuel - 1, n // 2) + ("0" if n % 2 == 0 else "1")

def nat_to_binary_string(n: int) -> str:
    if n == 0:
        return "0"
    return nat_to_binary_string_pos_aux(n, n)

def solve_impl(N: int) -> str:
    return nat_to_binary_string(sum_decimal_digits(N))

def problem_84_pre(N: int) -> bool:
    return N <= 10000

def problem_84_spec(N: int, output: str) -> bool:
    return output == solve_impl(N)

def _impl(N):
    s = sum(map(lambda x: int(x), str(N)))
    return bin(s)[2:]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_84_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_84_spec(*input, output))

def solve(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
