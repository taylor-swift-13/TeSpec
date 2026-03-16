from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    numbers, delimeter = input
    if not isinstance(numbers, list):
        return False
    if not isinstance(delimeter, int):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    numbers, delimeter = input
    if not isinstance(output, list):
        return False
    n = len(numbers)
    if n == 0:
        return output == []
    if n == 1:
        return len(output) == 1 and output[0] == numbers[0]
    if len(output) != 2 * n - 1:
        return False
    for i in range(n):
        if output[2 * i] != numbers[i]:
            return False
    for i in range(n - 1):
        if output[2 * i + 1] != delimeter:
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
