from typing import List

def problem_28_pre(input):
    return True

def problem_28_spec(input, output):
    return "".join(input) == output

def _impl(strings: List[str]) -> str:
    return "".join(strings)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_28_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_28_spec(*input, output))

def concatenate(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
