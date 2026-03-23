def count_sevens_nat(n: int, fuel: int) -> int:
    res = 0
    for _ in range(max(0, fuel)):
        is_7 = 1 if (n % 10) == 7 else 0
        if n < 10:
            return res + is_7
        res += is_7
        n //= 10
    return res

def count_sevens(z: int) -> int:
    n = max(0, z)
    return count_sevens_nat(n, n + 1)

def condition(i: int) -> bool:
    return (i % 11 == 0) or (i % 13 == 0)

def fizz_buzz_sum(n: int) -> int:
    n = max(0, n)
    res = 0
    for p in range(n):
        if condition(p):
            res += count_sevens(p)
    return res

def fizz_buzz_spec(n: int, cnt: int) -> bool:
    return cnt == fizz_buzz_sum(max(0, n))

def _impl(n: int):
    cnt = 0
    for i in range(n):
        if i % 11 == 0 or i % 13 == 0:
            cnt += len(list(filter(lambda c: c == "7", str(i))))
    return cnt

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(fizz_buzz_spec(*input, output))

def fizz_buzz(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
