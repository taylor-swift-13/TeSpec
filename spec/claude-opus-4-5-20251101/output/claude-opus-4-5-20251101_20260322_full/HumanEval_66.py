def is_upper(c: str) -> bool:
    n = ord(c)
    return 65 <= n <= 90

def ascii_to_Z(c: str) -> int:
    return ord(c)

def string_to_list(s: str) -> list:
    return list(s)

def sum_upper_ascii(chars: list) -> int:
    acc = 0
    for c in reversed(chars):
        if is_upper(c):
            acc = ascii_to_Z(c) + acc
    return acc

def digitSum_spec(s: str, result: int) -> bool:
    return result == sum_upper_ascii(string_to_list(s))

def _impl(s):
    return sum([ord(ch) for ch in s if ch.isupper()])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(digitSum_spec(*input, output))

def digitSum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
