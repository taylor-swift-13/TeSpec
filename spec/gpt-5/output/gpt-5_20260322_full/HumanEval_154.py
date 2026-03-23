def substring(s: str, sub: str) -> bool:
    return sub in s

def rotation_of(b: str, rot: str) -> bool:
    if len(b) != len(rot):
        return False
    for i in range(len(b) + 1):
        if rot == b[i:] + b[:i]:
            return True
    return False

def cycpattern_check_spec(a: str, b: str, res: bool) -> bool:
    expected = False
    if a == b or b == "":
        expected = True
    else:
        for i in range(len(b) + 1):
            rot = b[i:] + b[:i]
            if substring(a, rot):
                expected = True
                break
    return res == expected

def _impl(a, b):
    if a == b:
        return True
    if b == "":
        return True
    for i in range(0, len(b)):
        if b[i:] + b[:i] in a:
            return True
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(cycpattern_check_spec(*input, output))

def cycpattern_check(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
