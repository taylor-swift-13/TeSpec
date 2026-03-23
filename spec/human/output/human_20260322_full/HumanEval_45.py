def problem_45_pre(side, high):
    return side >= 0 and high >= 0

def problem_45_spec(side, high, output):
    return abs(output - (side * high / 2.0)) < 1e-9

def _impl(a, h):
    return a * h / 2

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_45_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_45_spec(*input, output))

def triangle_area(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
