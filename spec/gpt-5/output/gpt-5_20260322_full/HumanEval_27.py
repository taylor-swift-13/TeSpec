def is_lower_nat(n):
    return 97 <= n <= 122

def is_upper_nat(n):
    return 65 <= n <= 90

def swap_ascii(c):
    n = ord(c)
    if is_lower_nat(n):
        return chr(n - 32)
    elif is_upper_nat(n):
        return chr(n + 32)
    else:
        return c

def map_string(f, s):
    return "".join(f(c) for c in s)

def flip_case_spec(s, res):
    return res == map_string(swap_ascii, s)

def _impl(string: str) -> str:
    return "".join(map(lambda x: x.swapcase(), string))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(flip_case_spec(*input, output))

def flip_case(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
