def is_prime(n):
    if n <= 1:
        return False
    for m in range(2, int(n**0.5) + 1):
        if n % m == 0:
            return False
    return True

def digits_sum_aux(n, fuel):
    res = 0
    while fuel > 0 and n > 0:
        res += n % 10
        n //= 10
        fuel -= 1
    return res

def sum_digits(n):
    val = max(0, n)
    return digits_sum_aux(val, val + 1)

def skjkasdkd_spec(lst, res):
    primes = [p for p in lst if is_prime(p)]
    if not primes:
        return False
    max_prime = max(primes)
    return res == sum_digits(max_prime)

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
