import math

def problem_2_pre(x: float) -> bool:
    return x > 0

def problem_2_spec(x: float, frac: float) -> bool:
    expected_frac = x - math.floor(x)
    return abs(frac - expected_frac) <= 1e-7 and 0 <= frac < 1

def _impl(number: float) -> float:
    return number - int(number)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_2_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_2_spec(*input, output))

def truncate_number(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
