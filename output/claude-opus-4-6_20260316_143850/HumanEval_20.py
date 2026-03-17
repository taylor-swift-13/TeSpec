from typing import List, Tuple

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    return True


def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    a, b = output[0], output[1]
    # Result should be in non-decreasing order
    if a > b:
        return False
    # Both values must exist in the original list
    remaining = list(numbers)
    found_a = False
    for i, v in enumerate(remaining):
        if v == a:
            found_a = True
            remaining.pop(i)
            break
    if not found_a:
        return False
    found_b = False
    for i, v in enumerate(remaining):
        if v == b:
            found_b = True
            remaining.pop(i)
            break
    if not found_b:
        return False
    # The difference between the two should be the minimum possible difference
    # among all pairs
    diff = b - a
    min_diff = None
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            d = abs(numbers[i] - numbers[j])
            if min_diff is None or d < min_diff:
                min_diff = d
    if min_diff is None:
        return False
    if abs(diff - min_diff) > 1e-9:
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
