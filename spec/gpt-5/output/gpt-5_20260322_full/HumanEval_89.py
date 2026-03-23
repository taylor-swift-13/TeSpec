a_code = 97
z_code = 122

def is_lowercase_ascii(c: str) -> bool:
    n = ord(c)
    return a_code <= n and n <= z_code

def rot4_ascii(c: str) -> str:
    n = ord(c)
    if is_lowercase_ascii(c):
        return chr(a_code + ((n - a_code + 4) % 26))
    else:
        return c

def map_string(f, s: str) -> str:
    return "".join(f(c) for c in s)

def encrypt_spec(s: str, res: str) -> bool:
    return res == map_string(rot4_ascii, s)

def _impl(s):
    d = 'abcdefghijklmnopqrstuvwxyz'
    return "".join(map(lambda ch: chr((ord(ch) - ord("a") + 4) % 26 + ord("a")) if ch in d else ch, s))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(encrypt_spec(*input, output))

def encrypt(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
