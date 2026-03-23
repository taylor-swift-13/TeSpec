def list_ascii_of_string(s: str) -> list:
    return list(s)

def is_substring(sub: list, main: list) -> bool:
    n = len(sub)
    for i in range(len(main) - n + 1):
        if main[i:i+n] == sub:
            return True
    return False

def is_rotation_of(r: list, b: list) -> bool:
    if len(r) != len(b):
        return False
    for i in range(len(b) + 1):
        if r == b[i:] + b[:i]:
            return True
    return False

def problem_154_pre(a: str, b: str) -> bool:
    return True

def problem_154_spec(a: str, b: str, res: bool) -> bool:
    la = list_ascii_of_string(a)
    lb = list_ascii_of_string(b)
    
    exists_b_prime = False
    for i in range(len(lb) + 1):
        b_prime = lb[i:] + lb[:i]
        if is_substring(b_prime, la):
            exists_b_prime = True
            break
            
    return res == exists_b_prime

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_154_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_154_spec(*input, output))

def cycpattern_check(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
