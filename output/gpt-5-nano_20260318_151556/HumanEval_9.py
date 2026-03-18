from typing import List, Tuple

def precondition(input) -> bool:
    # Expect a single argument which is a list of integers
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    for x in numbers:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output) -> bool:
    # Check that input is a single argument which is a list of ints
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    # Output must be a list of the same length as numbers
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    # Validate running maximum property
    current_max = None
    for i, val in enumerate(numbers):
        if not isinstance(val, int):
            return False
        if i == 0:
            current_max = val
        else:
            if val > current_max:
                current_max = val
        if output[i] != current_max:
            return False
    return True

def _impl(numbers: List[int]) -> List[int]:
    """
    From a given list of integers, generate a list of rolling maximum element found until given moment
    in the sequence.
    [1, 2, 3, 3, 3, 4, 4]
    """
    return [max(numbers[:(i+1)]) for i in range(len(numbers))]

def rolling_max(numbers: List[int]) -> List[int]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
