def digitSum_fun(s: str) -> int:
    total = 0
    for ch in s:
        code = ord(ch)
        if 65 <= code <= 90:
            total += code
    return total

def digitSum_spec(s: str, sum: int) -> bool:
    return sum == digitSum_fun(s)

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
