def is_prime(p):
    if p <= 1:
        return False
    for d in range(2, p):
        if p % d == 0:
            return False
    return True

def is_factor(f, n):
    if f == 0:
        return n == 0
    return n % f == 0

def is_prime_factor(f, n):
    return is_prime(f) and is_factor(f, n)

def largest_prime_factor_spec(n, result):
    if n <= 1:
        return False
    if is_prime(n):
        return False
    if not is_prime_factor(result, n):
        return False
    for f in range(2, n + 1):
        if is_prime_factor(f, n):
            if f > result:
                return False
    return True

def _impl(n: int):
    isprime = [True] * (n + 1)
    for i in range(2, n + 1):
        if isprime[i]:
            for j in range(i + i, n, i):
                isprime[j] = False
    for i in range(n - 1, 0, -1):
        if isprime[i] and n % i == 0:
            return i

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(largest_prime_factor_spec(*input, output))

def largest_prime_factor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
