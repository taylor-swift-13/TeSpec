from typing import List, Tuple

def precondition(input):
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for num in numbers:
        if not isinstance(num, int) or isinstance(num, bool):
            return False
    return True

def postcondition(input, output):
    numbers = input[0]
    
    if not isinstance(output, list):
        return False
    
    if len(output) != len(numbers):
        return False
    
    if len(numbers) == 0:
        return output == []
    
    # Check that output contains rolling maximums
    expected_max = numbers[0]
    for i, num in enumerate(numbers):
        if num > expected_max:
            expected_max = num
        if output[i] != expected_max:
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
