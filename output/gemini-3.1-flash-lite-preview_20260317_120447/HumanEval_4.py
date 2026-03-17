from typing import List

def precondition(input):
    numbers = input[0]
    return isinstance(numbers, list) and len(numbers) > 0 and all(isinstance(x, (int, float)) for x in numbers)

def postcondition(input, output):
    return isinstance(output, (int, float)) and output >= 0

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
