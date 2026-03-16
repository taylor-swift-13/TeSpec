from typing import List, Tuple

def precondition(input):
    try:
        nums = input[0]
    except Exception:
        return False
    if not isinstance(nums, list):
        return False
    for x in nums:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    try:
        nums = input[0]
    except Exception:
        return False
    if not isinstance(nums, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(nums):
        return False
    if len(nums) == 0:
        return output == []
    for x in output:
        if not isinstance(x, int):
            return False
    # Each output element must equal the maximum of nums up to that index
    for i in range(len(nums)):
        try:
            expected = max(nums[:i+1])
        except ValueError:
            return False
        if output[i] != expected:
            return False
    # Monotonic non-decreasing check (redundant but safe)
    for i in range(1, len(output)):
        if output[i] < output[i-1]:
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
