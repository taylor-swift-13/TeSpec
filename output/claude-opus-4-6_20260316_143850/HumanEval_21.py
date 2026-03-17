from typing import List

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    min_val = min(numbers)
    max_val = max(numbers)
    if max_val == min_val:
        return False
    return True


def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(numbers):
        return False
    for v in output:
        if not isinstance(v, (int, float)):
            return False
    min_out = min(output)
    max_out = max(output)
    if abs(min_out - 0.0) > 1e-6:
        return False
    if abs(max_out - 1.0) > 1e-6:
        return False
    # Check that the transform is linear: relative differences preserved
    min_in = min(numbers)
    max_in = max(numbers)
    range_in = max_in - min_in
    for i in range(len(numbers)):
        expected = (numbers[i] - min_in) / range_in
        if abs(output[i] - expected) > 1e-6:
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
