from typing import List

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) == 0:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, (int, float)):
        return False
    if output < 0:
        return False
    numbers = input[0]
    mean = sum(numbers) / len(numbers)
    expected = sum(abs(x - mean) for x in numbers) / len(numbers)
    return abs(output - expected) < 1e-6

def _impl(numbers: List[float]) -> float:
    """For a given list of input numbers, calculate Mean Absolute Deviation
    around the mean of this dataset.
    Mean Absolute Deviation is the average absolute difference between each
    element and a centerpoint (mean in this case):
    MAD = average | x - x_mean |
    1.0"""
    mean = sum(numbers) / len(numbers)
    return sum(abs(x - mean) for x in numbers) / len(numbers)

def mean_absolute_deviation(numbers: List[float]) -> float:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
