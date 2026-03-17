from typing import List

def precondition(args) -> bool:
    if len(args) != 1:
        return False
    numbers = args[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    if not all(isinstance(x, (int, float)) for x in numbers):
        return False
    if max(numbers) <= min(numbers):
        return False
    return True

def postcondition(args, output) -> bool:
    numbers = args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    if not all(isinstance(x, (int, float)) for x in output):
        return False
    if len(output) >= 2:
        if abs(min(output) - 0.0) > 1e-5:
            return False
        if abs(max(output) - 1.0) > 1e-5:
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
