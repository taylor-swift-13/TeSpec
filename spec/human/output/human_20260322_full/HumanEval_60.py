def problem_60_pre(n: int) -> bool:
    return n > 0

def problem_60_spec(n: int, output: int) -> bool:
    return 2 * output == n * (n + 1)

def _impl(n: int):
    return (n + 1) * n // 2

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_60_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_60_spec(*input, output))

def sum_to_n(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
