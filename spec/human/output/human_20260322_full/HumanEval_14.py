from typing import List

def problem_14_pre(input: str) -> bool:
    return True

def problem_14_spec(input: str, output: list) -> bool:
    if len(input) == 0:
        return output == []
    else:
        if len(output) != len(input):
            return False
        for i in range(len(input)):
            if len(output[i]) != i + 1:
                return False
            if not input.startswith(output[i]):
                return False
        return True

def _impl(string: str) -> List[str]:
    return [string[:(i + 1)] for i in range(len(string))]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_14_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_14_spec(*input, output))

def all_prefixes(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
