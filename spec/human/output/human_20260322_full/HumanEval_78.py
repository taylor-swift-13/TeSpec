def is_prime_hex_digit(c):
    return c in ('2', '3', '5', '7', 'B', 'D')

def count_prime_hex(s):
    return sum(1 for c in s if is_prime_hex_digit(c))

def hex_key_impl(s):
    return count_prime_hex(s)

def problem_78_pre(s):
    return True

def problem_78_spec(s, output):
    return output == hex_key_impl(s)

def _impl(num):
    return len(list(filter(lambda x: x in "2357BD", num)))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_78_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_78_spec(*input, output))

def hex_key(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
