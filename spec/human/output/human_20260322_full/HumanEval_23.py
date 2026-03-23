def problem_23_pre(input: str) -> bool:
    return True

def problem_23_spec(input: str, output: int) -> bool:
    return output == len(input)

def _impl(string: str) -> int:
    return len(string)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_23_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_23_spec(*input, output))

def strlen(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
