def problem_75_pre(a: int) -> bool:
    return a < 100

def problem_75_spec(a: int, b: bool) -> bool:
    if a < 2:
        is_mult = False
    else:
        count = 0
        n = a
        d = 2
        while d * d <= n:
            while n % d == 0:
                count += 1
                n //= d
                if count > 3:
                    break
            if count > 3:
                break
            d += 1
        if n > 1:
            count += 1
        is_mult = (count == 3)
        
    return b == is_mult

def _impl(a):
    if a <= 1: return False
    isprime = [True] * (a + 1)
    for i in range(2, a + 1):
        if isprime[i]:
            for j in range(i + i, a + 1, i):
                isprime[j] = False
    cnt, tmp = 0, a
    for i in range(2, a + 1):
        while isprime[i] and tmp % i == 0:
            tmp //= i
            cnt += 1
    return cnt == 3

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_75_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_75_spec(*input, output))

def is_multiply_prime(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
