from typing import List

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 2:
        return False
    numbers, delimeter = inputs
    if not isinstance(numbers, list):
        return False
    if not all(isinstance(x, int) for x in numbers):
        return False
    if not isinstance(delimeter, int):
        return False
    return True

def postcondition(inputs: tuple, output: list) -> bool:
    numbers, delimeter = inputs
    if not isinstance(output, list):
        return False
    if len(numbers) == 0:
        return len(output) == 0
    if len(output) != 2 * len(numbers) - 1:
        return False
    for i in range(len(output)):
        if i % 2 == 0:
            if output[i] != numbers[i // 2]:
                return False
        else:
            if output[i] != delimeter:
                return False
    return True

def _impl(numbers: List[int], delimeter: int) -> List[int]:
    """Insert a number 'delimeter' between every two consecutive elements of input list `numbers'
    []
    [1, 4, 2, 4, 3]"""
    res = []
    for i in range(len(numbers)):
        res.append(numbers[i])
        if i != len(numbers) - 1:
            res.append(delimeter)
    return res

def intersperse(numbers: List[int], delimeter: int) -> List[int]:
    _input = (numbers, delimeter)
    assert precondition(_input)
    _output = _impl(numbers, delimeter)
    assert postcondition(_input, _output)
    return _output
