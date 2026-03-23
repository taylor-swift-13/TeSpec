def sum_digits_fueled(n: int, fuel: int) -> int:
    if fuel == 0:
        return 0
    if n == 0:
        return 0
    return (n % 10) + sum_digits_fueled(n // 10, fuel - 1)

def sum_digits(n: int) -> int:
    return sum_digits_fueled(n, n)

def problem_94_pre(lst: list) -> bool:
    return True

def is_prime(n: int) -> bool:
    if n < 2:
        return False
    for i in range(2, int(n**0.5) + 1):
        if n % i == 0:
            return False
    return True

def problem_94_spec(lst: list, output: int) -> bool:
    primes = [x for x in lst if is_prime(x)]
    if not primes:
        return output == 0
    max_prime = max(primes)
    return output == sum_digits(max_prime)

def _impl(lst):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    sorted_list = sorted(lst)[::-1]
    for x in sorted_list:
        if is_prime(x):
            return sum(map(lambda ch: int(ch), str(x)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_94_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_94_spec(*input, output))

def skjkasdkd(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
