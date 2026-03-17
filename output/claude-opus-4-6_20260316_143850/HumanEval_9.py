from typing import List, Tuple

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if not all(isinstance(n, int) for n in numbers):
        return False
    return True


def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    if len(numbers) == 0:
        return True
    # First element should equal first input
    if output[0] != numbers[0]:
        return False
    # Each output element should be the max of all inputs up to that index
    for i in range(len(numbers)):
        if output[i] != max(numbers[:i+1]):
            return False
    # Rolling max should be non-decreasing
    for i in range(1, len(output)):
        if output[i] < output[i-1]:
            return False
    # Each output element should be >= corresponding input element
    for i in range(len(numbers)):
        if output[i] < numbers[i]:
            return False
    return True

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
