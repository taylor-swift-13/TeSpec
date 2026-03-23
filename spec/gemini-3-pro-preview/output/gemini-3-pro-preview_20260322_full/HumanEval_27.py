def is_lower(c: str) -> bool:
    n = ord(c)
    return 97 <= n <= 122

def is_upper(c: str) -> bool:
    n = ord(c)
    return 65 <= n <= 90

def flip_char(c: str) -> str:
    if is_lower(c):
        return chr(ord(c) - 32)
    elif is_upper(c):
        return chr(ord(c) + 32)
    else:
        return c

def flip_case_model(s: str) -> str:
    return "".join(flip_char(c) for c in s)

def flip_case_spec(s: str, res: str) -> bool:
    return res == flip_case_model(s)

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
