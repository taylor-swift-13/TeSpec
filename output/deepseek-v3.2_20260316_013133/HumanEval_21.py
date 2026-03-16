from typing import List

def precondition(input):
    numbers, = input
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input, output):
    numbers, = input
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    if len(output) == 0:
        return False
    for y in output:
        if not isinstance(y, (int, float)):
            return False
    min_val = min(numbers)
    max_val = max(numbers)
    if max_val == min_val:
        return all(y == 0.0 for y in output)
    for i, y in enumerate(output):
        x = numbers[i]
        expected = (x - min_val) / (max_val - min_val)
        if not (abs(y - expected) < 1e-12):
            return False
    return True

def _impl(numbers: List[float]) -> List[float]:
    """Given list of numbers (of at least two elements), apply a linear transform to that list,
    such that the smallest number will become 0 and the largest will become 1
    [0.0, 0.25, 0.5, 0.75, 1.0]"""
    ma, mi = max(numbers), min(numbers)
    k = 1 / (ma - mi)
    return list(map(lambda x: (x - mi) * k, numbers))

def rescale_to_unit(numbers: List[float]) -> List[float]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
