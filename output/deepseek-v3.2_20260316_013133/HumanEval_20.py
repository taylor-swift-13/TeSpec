from typing import List, Tuple

def precondition(input):
    numbers, = input
    return isinstance(numbers, list) and len(numbers) >= 2 and all(isinstance(x, (int, float)) for x in numbers)

def postcondition(input, output):
    numbers, = input
    if not precondition(input):
        return False
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    a, b = output
    if not (isinstance(a, (int, float)) and isinstance(b, (int, float))):
        return False
    if a > b:
        return False
    if a not in numbers or b not in numbers:
        return False
    if len(numbers) == 2:
        return a == min(numbers) and b == max(numbers)
    min_diff = min(abs(x - y) for i, x in enumerate(numbers) for j, y in enumerate(numbers) if i != j)
    return abs(a - b) == min_diff

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
