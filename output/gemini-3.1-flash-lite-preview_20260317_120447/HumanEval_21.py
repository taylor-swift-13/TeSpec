from typing import List

def precondition(input):
    numbers = input[0]
    return isinstance(numbers, list) and len(numbers) >= 2 and all(isinstance(x, (int, float)) for x in numbers)

def postcondition(input, output):
    numbers = input[0]
    if min(numbers) == max(numbers):
        return all(x == 0.0 for x in output)
    return all(0.0 <= x <= 1.0 for x in output) and min(output) == 0.0 and max(output) == 1.0

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
