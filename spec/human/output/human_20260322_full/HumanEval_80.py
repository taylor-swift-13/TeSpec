def problem_80_pre(s: str) -> bool:
    return True

def problem_80_spec(s: str, output: bool) -> bool:
    if len(s) < 3:
        is_happy = False
    else:
        is_happy = True
        for i in range(len(s) - 2):
            c1 = s[i]
            c2 = s[i + 1]
            c3 = s[i + 2]
            if c1 == c2 or c1 == c3 or c2 == c3:
                is_happy = False
                break
                
    return is_happy == output

def _impl(s):
    if len(s) < 3: return False
    for i in range(len(s) - 2):
        if s[i] == s[i + 1] or s[i] == s[i + 2] or s[i + 1] == s[i + 2]:
            return False
    return True

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_80_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_80_spec(*input, output))

def is_happy(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
