from typing import List

def precondition(input):
    # Expect a single positional argument: numbers as a non-empty list of real numbers (not bool)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if type(x) not in (int, float):
            return False
        if isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    import math
    if not precondition(input):
        return False
    nums = input[0]
    n = len(nums)
    mean = sum(nums) / n
    expected = sum(abs(x - mean) for x in nums) / n
    if isinstance(output, (int, float)):
        if math.isnan(expected) and math.isnan(output):
            return True
        return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-9)
    return False

def _impl(numbers: List[float]) -> float:
    """For a given list of input numbers, calculate Mean Absolute Deviation
    around the mean of this dataset.
    Mean Absolute Deviation is the average absolute difference between each
    element and a centerpoint (mean in this case):
    MAD = average | x - x_mean |
    1.0"""
    mean = sum(numbers) / len(numbers)
    return sum(abs(x - mean) for x in numbers) / len(numbers)

def mean_absolute_deviation(numbers: List[float]) -> float:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
