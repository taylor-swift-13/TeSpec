def string_append(s1: str, s2: str) -> str:
    return s1 + s2

def string_in(s1: str, s2: str) -> bool:
    return s1 in s2

def string_eq(s1: str, s2: str) -> bool:
    return s1 == s2

def string_length(s: str) -> int:
    return len(s)

def cycpattern_check_spec(a: str, b: str, result: bool) -> bool:
    expected = False
    if string_eq(b, ""):
        expected = True
    elif string_eq(a, b):
        expected = True
    else:
        for i in range(string_length(b)):
            shifted = string_append(b[i:], b[:i])
            if string_in(shifted, a):
                expected = True
                break
                
    return result == expected

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
