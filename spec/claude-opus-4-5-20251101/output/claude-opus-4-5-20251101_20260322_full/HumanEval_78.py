def is_prime_hex_digit(c):
    return c in ['2', '3', '5', '7', 'B', 'D']

def string_to_list(s):
    return list(s)

def count_prime_hex_digits(chars):
    count = 0
    for c in chars:
        if is_prime_hex_digit(c):
            count += 1
    return count

def hex_key_spec(num, result):
    return result == count_prime_hex_digits(string_to_list(num))

def _impl(num):
    return len(list(filter(lambda x: x in "2357BD", num)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(hex_key_spec(*input, output))

def hex_key(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
