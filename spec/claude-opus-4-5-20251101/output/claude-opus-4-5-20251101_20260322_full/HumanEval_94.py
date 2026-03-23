def is_prime(n: int) -> bool:
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True

def sum_of_digits(n: int) -> int:
    acc = 0
    m = n
    for _ in range(100):
        if m <= 0:
            return acc
        acc += m % 10
        m = m // 10
    return acc

def is_largest_prime(x: int, lst: list) -> bool:
    if x not in lst:
        return False
    if not is_prime(x):
        return False
    for y in lst:
        if is_prime(y) and y > x:
            return False
    return True

def skjkasdkd_spec(lst: list, result: int) -> bool:
    primes = [x for x in lst if is_prime(x)]
    if not primes:
        return result == 0
    largest_prime = max(primes)
    return result == sum_of_digits(largest_prime)

def _impl(lst):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    sorted_list = sorted(lst)[::-1]
    for x in sorted_list:
        if is_prime(x):
            return sum(map(lambda ch: int(ch), str(x)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(skjkasdkd_spec(*input, output))

def skjkasdkd(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
