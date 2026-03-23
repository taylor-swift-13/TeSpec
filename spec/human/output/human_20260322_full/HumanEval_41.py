def problem_41_pre(input: int) -> bool:
    return True

def problem_41_spec(input: int, output: int) -> bool:
    return output == input * input

def _impl(n: int):
    return n ** 2

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_41_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_41_spec(*input, output))

def car_race_collision(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
