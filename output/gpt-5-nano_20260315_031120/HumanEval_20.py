from typing import List, Tuple

def precondition(input):
    import math
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
        if not math.isfinite(x):
            return False
    return True

def postcondition(input, output):
    import math
    from collections import Counter

    if not isinstance(input, tuple) or len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list) or len(numbers) < 2:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
        if not math.isfinite(x):
            return False

    if not isinstance(output, tuple) or len(output) != 2:
        return False
    a, b = output
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return False
    if a > b:
        return False

    counts = Counter(numbers)
    if a == b:
        if counts[a] < 2:
            return False
    else:
        if counts[a] < 1 or counts[b] < 1:
            return False

    sorted_arr = sorted(numbers)
    min_diff = float('inf')
    for i in range(1, len(sorted_arr)):
        diff = sorted_arr[i] - sorted_arr[i-1]
        if diff < min_diff:
            min_diff = diff

    diff_ab = b - a
    if diff_ab != min_diff:
        if not abs(diff_ab - min_diff) <= 1e-12:
            return False

    if a == b:
        if min_diff != 0:
            return False
        return True

    if abs(diff_ab - min_diff) > 1e-12:
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
