from typing import List

def char_to_bool(c: str) -> bool:
    return c == '1'

def bool_to_char(b: bool) -> str:
    return '1' if b else '0'

def xor_ascii(c1: str, c2: str) -> str:
    return bool_to_char(char_to_bool(c1) ^ char_to_bool(c2))

def string_xor_spec(a: str, b: str, result: str) -> bool:
    if len(result) != len(a):
        return False
    for i in range(len(a)):
        char_a = a[i]
        char_b = b[i] if i < len(b) else '0'
        char_r = result[i]
        if char_r != xor_ascii(char_a, char_b):
            return False
    return True

def _impl(a: str, b: str) -> str:
    return "".join(str(int(a[i]) ^ int(b[i])) for i in range(len(a)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(string_xor_spec(*input, output))

def string_xor(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
