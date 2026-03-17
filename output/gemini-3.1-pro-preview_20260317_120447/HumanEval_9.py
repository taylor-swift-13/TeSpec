from typing import List, Tuple

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    numbers = inputs[0]
    if not isinstance(numbers, list):
        return False
    return all(isinstance(x, int) for x in numbers)

def postcondition(inputs: tuple, output: list) -> bool:
    numbers = inputs[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    
    current_max = None
    for i in range(len(numbers)):
        if current_max is None or numbers[i] > current_max:
            current_max = numbers[i]
        if output[i] != current_max:
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
