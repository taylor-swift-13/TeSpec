def has_divisor_upto(n, k):
    for i in range(k, 1, -1):
        if n % i == 0:
            return True
    return False

def is_primeb(a):
    if a < 2:
        return False
    return not has_divisor_upto(a, a - 1)

def prime_length_spec(s, b):
    return b == is_primeb(len(s))

def _impl(string):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return is_prime(len(string))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(prime_length_spec(*input, output))

def prime_length(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
