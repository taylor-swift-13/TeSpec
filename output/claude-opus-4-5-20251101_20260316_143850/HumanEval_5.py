from typing import List

def precondition(input) -> bool:
    if len(input) != 2:
        return False
    numbers, delimeter = input
    if not isinstance(numbers, list):
        return False
    if not isinstance(delimeter, int):
        return False
    if not all(isinstance(n, int) for n in numbers):
        return False
    return True


def postcondition(input, output) -> bool:
    numbers, delimeter = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(n, int) for n in output):
        return False
    if len(numbers) <= 1:
        return output == numbers
    expected_length = len(numbers) * 2 - 1
    if len(output) != expected_length:
        return False
    for i in range(len(numbers)):
        if output[i * 2] != numbers[i]:
            return False
    for i in range(len(numbers) - 1):
        if output[i * 2 + 1] != delimeter:
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
