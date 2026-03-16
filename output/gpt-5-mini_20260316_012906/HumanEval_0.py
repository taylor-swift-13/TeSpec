from typing import List

import math
from typing import Any

def precondition(inp: Any) -> bool:
    # expect a tuple of (numbers, threshold)
    if not isinstance(inp, tuple) or len(inp) != 2:
        return False
    nums, thresh = inp
    # nums should be a list or tuple of numeric values
    if not isinstance(nums, (list, tuple)):
        return False
    for x in nums:
        if not (isinstance(x, (int, float)) and not isinstance(x, bool)):
            return False
        if not math.isfinite(float(x)):
            return False
    # threshold must be a finite non-negative real number (int/float, not bool)
    if not (isinstance(thresh, (int, float)) and not isinstance(thresh, bool)):
        return False
    if not math.isfinite(float(thresh)):
        return False
    if float(thresh) < 0:
        return False
    return True

def postcondition(inp: Any, out: Any) -> bool:
    if not precondition(inp):
        return False
    if not isinstance(out, bool):
        return False
    nums, thresh = inp
    n = len(nums)
    # If output is True, there must exist a pair with absolute difference < thresh
    if out:
        for i in range(n):
            for j in range(i+1, n):
                if abs(nums[i] - nums[j]) < thresh:
                    return True
        return False
    else:
        # If output is False, there must be no pair with absolute difference < thresh
        for i in range(n):
            for j in range(i+1, n):
                if abs(nums[i] - nums[j]) < thresh:
                    return False
        return True

def _impl(numbers: List[float], threshold: float) -> bool:
    """Check if in given list of numbers, are any two numbers closer to each other than
    given threshold.
    False
    True"""
    sorted_numbers = sorted(numbers)
    for i in range(len(sorted_numbers) - 1):
        if sorted_numbers[i + 1] - sorted_numbers[i] < threshold:
            return True
    return False

def has_close_elements(numbers: List[float], threshold: float) -> bool:
    _input = (numbers, threshold)
    assert precondition(_input)
    _output = _impl(numbers, threshold)
    assert postcondition(_input, _output)
    return _output
