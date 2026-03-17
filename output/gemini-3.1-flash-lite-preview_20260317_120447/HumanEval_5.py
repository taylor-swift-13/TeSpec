from typing import List

def precondition(input):
    numbers, delimeter = input
    return isinstance(numbers, list) and all(isinstance(x, int) for x in numbers) and isinstance(delimeter, int)

def postcondition(input, output):
    numbers, delimeter = input
    if not isinstance(output, list):
        return False
    if not numbers:
        return output == []
    if len(numbers) == 1:
        return output == numbers
    
    expected_len = 2 * len(numbers) - 1
    if len(output) != expected_len:
        return False
    
    for i in range(len(numbers)):
        if output[2 * i] != numbers[i]:
            return False
    for i in range(len(numbers) - 1):
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
