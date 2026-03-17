from typing import List

def precondition(args):
    numbers = args[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
    if min(numbers) == max(numbers):
        return False
    return True


def postcondition(args, output):
    numbers = args[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    for x in output:
        if not isinstance(x, (int, float)):
            return False
        if x < 0.0 - 1e-9 or x > 1.0 + 1e-9:
            return False
    if abs(min(output) - 0.0) > 1e-9:
        return False
    if abs(max(output) - 1.0) > 1e-9:
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
