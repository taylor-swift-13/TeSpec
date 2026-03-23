def problem_53_pre(x: int, y: int) -> bool:
    return True

def problem_53_spec(x: int, y: int, output: int) -> bool:
    return output == x + y

def _impl(x: int, y: int):
    return x + y

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_53_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_53_spec(*input, output))

def add(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
