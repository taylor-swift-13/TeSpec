def happy(s: str) -> bool:
    if len(s) < 3:
        return False
    for i in range(len(s) - 2):
        a = s[i]
        b = s[i + 1]
        c = s[i + 2]
        if a == b or a == c or b == c:
            return False
    return True

def is_happy_spec(s: str, res: bool) -> bool:
    return res == happy(s)

def _impl(s):
    if len(s) < 3: return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_happy_spec(*input, output))

def is_happy(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
