from typing import List, Tuple

def precondition(input):
    numbers = input[0]
    return isinstance(numbers, list) and len(numbers) >= 2 and all(isinstance(x, (int, float)) for x in numbers)

def postcondition(input, output):
    numbers = input[0]
    a, b = output
    return a <= b and a in numbers and b in numbers and all(abs(x - y) >= abs(a - b) for i, x in enumerate(numbers) for j, y in enumerate(numbers) if i != j)

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
