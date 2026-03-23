def is_substring(part: str, whole: str) -> bool:
    return part in whole

def is_rotation(s: str, r: str) -> bool:
    return len(s) == len(r) and s in r + r

def cycpattern_check_spec(a: str, b: str, res: bool) -> bool:
    has_rot_substr = False
    if len(b) == 0:
        has_rot_substr = True
    else:
        for i in range(len(b)):
            r = b[i:] + b[:i]
            if is_substring(r, a):
                has_rot_substr = True
                break
                
    return res == has_rot_substr

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
