from typing import List, Tuple

import math
from collections import Counter

def precondition(input):
    # input is tuple of positional args: (numbers,)
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    nums = input[0]
    if not isinstance(nums, (list, tuple)):
        return False
    if len(nums) < 2:
        return False
    for x in nums:
        if not isinstance(x, (int, float)):
            return False
        # disallow NaN and infinities
        if isinstance(x, float):
            if math.isnan(x) or math.isinf(x):
                return False
    return True

def postcondition(input, output):
    # Only meaningful when precondition holds
    if not precondition(input):
        return False
    nums = list(input[0])
    # output must be a pair (list or tuple) of length 2
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != 2:
        return False
    a, b = output[0], output[1]
    # elements must be numeric and finite
    for v in (a, b):
        if not isinstance(v, (int, float)):
            return False
        if isinstance(v, float) and (math.isnan(v) or math.isinf(v)):
            return False
    # Ensure non-decreasing order: a <= b (allow for floating closeness)
    if not (a <= b or math.isclose(a, b, rel_tol=1e-12, abs_tol=1e-12)):
        return False
    # ensure output values come from input with sufficient multiplicity
    counts = Counter(nums)
    # Use == for membership (consistent with precondition numbers being ints/floats)
    if a == b:
        if counts[a] < 2:
            return False
    else:
        if counts[a] < 1 or counts[b] < 1:
            return False
    # compute minimal absolute difference among all pairs
    n = len(nums)
    min_diff = None
    for i in range(n):
        for j in range(i+1, n):
            diff = abs(nums[i] - nums[j])
            if min_diff is None or diff < min_diff:
                min_diff = diff
    if min_diff is None:
        return False
    out_diff = abs(b - a)
    # out_diff must match minimal difference within tolerance
    if not math.isclose(out_diff, min_diff, rel_tol=1e-12, abs_tol=1e-12):
        return False
    # Additionally ensure there exists at least one pair of indices in nums
    # whose values correspond to the output values and whose difference matches out_diff
    found = False
    for i in range(n):
        for j in range(i+1, n):
            if math.isclose(abs(nums[i] - nums[j]), out_diff, rel_tol=1e-12, abs_tol=1e-12):
                # check that the unordered pair of values equals the unordered pair of output values
                vi, vj = nums[i], nums[j]
                if (vi == a and vj == b) or (vi == b and vj == a):
                    found = True
                    break
        if found:
            break
    if not found:
        return False
    return True

def _impl(numbers: List[float]) -> Tuple[float, float]:
    """From a supplied list of numbers (of length at least two) select and return two that are the closest to each
    other and return them in order (smaller number, larger number).
    (2.0, 2.2)
    (2.0, 2.0)"""
    numbers.sort()
    min_diff = float("inf")
    min_pair = None
    for l, r in zip(numbers[:-1], numbers[1:]):
        diff = r - l
        if diff < min_diff:
            min_diff = diff
            min_pair = (l, r)
    return min_pair

def find_closest_elements(numbers: List[float]) -> Tuple[float, float]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
