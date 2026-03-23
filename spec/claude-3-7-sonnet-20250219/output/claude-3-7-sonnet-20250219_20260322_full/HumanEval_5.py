from typing import List

def intersperse_spec(numbers, delimeter, res):
    expected = []
    if numbers:
        expected.append(numbers[0])
        for num in numbers[1:]:
            expected.append(delimeter)
            expected.append(num)
    return res == expected

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
