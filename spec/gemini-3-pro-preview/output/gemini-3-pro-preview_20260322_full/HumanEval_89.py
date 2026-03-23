def is_lowercase(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def rotate_char(c: str) -> str:
    if is_lowercase(c):
        n = ord(c)
        return chr(97 + (n - 97 + 4) % 26)
    else:
        return c

def encrypt_model(s: str) -> str:
    return "".join(rotate_char(c) for c in s)

def encrypt_spec(s: str, result: str) -> bool:
    return result == encrypt_model(s)

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
