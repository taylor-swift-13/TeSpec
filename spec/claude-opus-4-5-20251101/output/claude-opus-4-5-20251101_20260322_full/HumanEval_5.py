from typing import List

def intersperse_spec_aux(numbers, delimiter):
    if not numbers:
        return []
    res = []
    for x in numbers[:-1]:
        res.append(x)
        res.append(delimiter)
    res.append(numbers[-1])
    return res

def intersperse_spec(numbers, delimiter, result):
    return result == intersperse_spec_aux(numbers, delimiter)

def _impl(numbers: List[int], delimeter: int) -> List[int]:
    res = []
    for i in range(len(numbers)):
        res.append(numbers[i])
        if i != len(numbers) - 1:
            res.append(delimeter)
    return res

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(intersperse_spec(*input, output))

def intersperse(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
