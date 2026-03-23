from typing import List

def problem_5_pre(input, output):
    return True

def problem_5_spec(input, output, d):
    if not input:
        return output == []

    n = len(input)
    if len(output) != 2 * n - 1:
        return False

    for i in range(len(output)):
        if i % 2 == 0:
            if output[i] != input[i // 2]:
                return False
        else:
            if output[i] != d:
                return False
                
    return True

def _impl(numbers: List[int], delimeter: int) -> List[int]:
    res = []
    for i in range(len(numbers)):
        res.append(numbers[i])
        if i != len(numbers) - 1:
            res.append(delimeter)
    return res

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_5_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_5_spec(*input, output))

def intersperse(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
