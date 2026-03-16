from typing import List

import math
import numbers

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    if len(nums) == 0:
        return False
    for x in nums:
        if not isinstance(x, numbers.Real):
            return False
        # exclude NaN and infinite values
        try:
            if math.isnan(x) or math.isinf(x):
                return False
        except Exception:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    nums = list(input[0])
    if not isinstance(output, numbers.Real):
        return False
    try:
        if math.isnan(output) or math.isinf(output):
            return False
    except Exception:
        return False
    n = len(nums)
    if n == 0:
        return False
    mean = sum(nums) / n
    expected = sum(abs(x - mean) for x in nums) / n
    # allow small numerical tolerance
    return math.isclose(output, expected, rel_tol=1e-9, abs_tol=1e-12) and output >= -1e-12

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
