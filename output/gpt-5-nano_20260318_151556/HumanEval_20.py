from typing import List, Tuple

def precondition(input):
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
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    a, b = output
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return False
    if a > b:
        return False
    numbers = input[0]
    from collections import Counter
    counts = Counter(numbers)
    if a == b:
        if counts[a] < 2:
            return False
    else:
        if counts[a] < 1 or counts[b] < 1:
            return False
    min_dist = None
    n = len(numbers)
    for i in range(n):
        for j in range(i + 1, n):
            d = abs(numbers[i] - numbers[j])
            if min_dist is None or d < min_dist:
                min_dist = d
    if min_dist is None:
        return False
    pair_dist = abs(a - b)
    import math
    if not math.isclose(pair_dist, min_dist, rel_tol=1e-12, abs_tol=1e-12):
        return False
    return True

def _impl(numbers: List[float]) -> Tuple[float, float]:
    """
    From a supplied list of numbers (of length at least two) select and return two that are the closest to each
    other and return them in order (smaller number, larger number).
    (2.0, 2.2)
    (2.0, 2.0)
    """
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
