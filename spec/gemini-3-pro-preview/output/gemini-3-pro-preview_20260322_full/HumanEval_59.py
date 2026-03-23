def is_prime(k):
    if k <= 1:
        return False
    if k == 2:
        return True
    if k % 2 == 0:
        return False
    for i in range(3, int(k**0.5) + 1, 2):
        if k % i == 0:
            return False
    return True

def get_largest_prime_factor(n):
    if n == 0:
        return None
    n = abs(n)
    largest = None
    if n % 2 == 0:
        largest = 2
        while n % 2 == 0:
            n //= 2
    i = 3
    while i * i <= n:
        if n % i == 0:
            largest = i
            while n % i == 0:
                n //= i
        i += 2
    if n > 1:
        largest = n
    return largest

def largest_prime_factor_spec(n, result):
    if not is_prime(result):
        return False
    if n != 0 and n % result != 0:
        return False
    actual_largest = get_largest_prime_factor(n)
    return actual_largest == result

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
