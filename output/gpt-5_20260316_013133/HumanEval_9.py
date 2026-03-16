from typing import List, Tuple

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    return all(isinstance(x, int) for x in numbers)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    expected = []
    curr = None
    for x in numbers:
        if curr is None or x > curr:
            curr = x
        expected.append(curr)
    return output == expected

def _impl(numbers: List[int]) -> List[int]:
    """From a given list of integers, generate a list of rolling maximum element found until given moment
    in the sequence.
    [1, 2, 3, 3, 3, 4, 4]"""
    return [max(numbers[:(i+1)]) for i in range(len(numbers))]

def rolling_max(numbers: List[int]) -> List[int]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
