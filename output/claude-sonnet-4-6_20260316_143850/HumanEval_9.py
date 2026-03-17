from typing import List, Tuple

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True


def postcondition(input, output) -> bool:
    numbers = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    if len(numbers) == 0:
        return True
    # Each element in output should be the max of numbers[:i+1]
    running_max = numbers[0]
    for i, val in enumerate(output):
        if not isinstance(val, int):
            return False
        running_max = max(running_max, numbers[i])
        if val != running_max:
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
