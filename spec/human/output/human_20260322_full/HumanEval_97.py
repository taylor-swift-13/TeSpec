def problem_97_pre(a, b):
    return True

def problem_97_spec(a, b, r):
    return r == (abs(a) % 10) * (abs(b) % 10)

def _impl(a, b):
    return int(str(a)[-1]) * int(str(b)[-1])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_97_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_97_spec(*input, output))

def multiply(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
