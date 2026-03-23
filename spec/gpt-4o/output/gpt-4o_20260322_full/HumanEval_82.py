import math

def is_prime_spec(a, result):
    if a < 2:
        expected = False
    else:
        expected = True
        limit = math.isqrt(a)
        for x in range(2, limit + 1):
            if a % x == 0:
                expected = False
                break
    return result == expected

def prime_length_spec(string, result):
    return is_prime_spec(len(string), result)

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
