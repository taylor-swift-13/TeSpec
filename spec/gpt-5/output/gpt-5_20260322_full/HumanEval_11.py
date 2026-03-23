from typing import List

def ascii_of_bool(b: bool) -> str:
    return "1" if b else "0"

def bool_of_ascii(c: str):
    if c == "0":
        return False
    elif c == "1":
        return True
    return None

def xor_ascii(a: str, b: str):
    x = bool_of_ascii(a)
    y = bool_of_ascii(b)
    if x is not None and y is not None:
        return ascii_of_bool(x ^ y)
    return None

def string_xor_prefix(a: str, b: str, r: str) -> bool:
    if len(a) != len(r):
        return False
    if len(b) < len(a):
        return False
    for i in range(len(a)):
        if xor_ascii(a[i], b[i]) != r[i]:
            return False
    return True

def string_xor_spec(a: str, b: str, r: str) -> bool:
    return string_xor_prefix(a, b, r)

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
