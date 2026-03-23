def is_upper(c):
    n = ord(c)
    return 65 <= n <= 90

def digitSum_calc(s):
    total = 0
    for c in s:
        if is_upper(c):
            total += ord(c)
    return total

def digitSum_spec(s, result):
    return result == digitSum_calc(s)

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
