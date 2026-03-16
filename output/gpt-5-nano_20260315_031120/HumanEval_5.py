from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    numbers, delimeter = input
    if not isinstance(numbers, list):
        return False
    if not all(isinstance(x, int) for x in numbers):
        return False
    if not isinstance(delimeter, int):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    numbers, delimeter = input
    if not isinstance(numbers, list) or not all(isinstance(x, int) for x in numbers):
        return False
    if not isinstance(delimeter, int):
        return False
    if not isinstance(output, list) or not all(isinstance(y, int) for y in output):
        return False

    expected = []
    n = len(numbers)
    for i, x in enumerate(numbers):
        expected.append(x)
        if i < n - 1:
            expected.append(delimeter)
    return output == expected

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
