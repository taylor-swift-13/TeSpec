from typing import List

def precondition(input):
    import math
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list) or len(nums) < 2:
        return False
    for x in nums:
        if not isinstance(x, (int, float)):
            return False
        if not math.isfinite(x):
            return False
    a = min(nums)
    b = max(nums)
    if a == b:
        return False
    return True

def postcondition(input, output):
    import math
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    nums = input[0]
    if not isinstance(nums, list) or len(nums) < 2:
        return False
    for x in nums:
        if not isinstance(x, (int, float)):
            return False
        if not math.isfinite(x):
            return False
    a = min(nums)
    b = max(nums)
    if a == b:
        return False
    if not isinstance(output, list) or len(output) != len(nums):
        return False
    denom = b - a
    if denom == 0:
        return False
    tol = 1e-9
    for xi, yi in zip(nums, output):
        if not isinstance(yi, (int, float)):
            return False
        if not math.isfinite(yi):
            return False
        if yi < -tol or yi > 1.0 + tol:
            return False
        expected = (xi - a) / denom
        if abs(yi - expected) > max(tol, abs(expected) * tol):
            return False
    return True

def _impl(numbers: List[float]) -> List[float]:
    """
    Given list of numbers (of at least two elements), apply a linear transform to that list,
    such that the smallest number will become 0 and the largest will become 1
    [0.0, 0.25, 0.5, 0.75, 1.0]
    """
    ma, mi = max(numbers), min(numbers)
    k = 1 / (ma - mi)
    return list(map(lambda x: (x - mi) * k, numbers))

def rescale_to_unit(numbers: List[float]) -> List[float]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
