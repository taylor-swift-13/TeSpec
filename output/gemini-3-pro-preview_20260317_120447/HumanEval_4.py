from typing import List

def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    numbers = input_args[0]
    if not isinstance(numbers, list) or len(numbers) == 0:
        return False
    return all(isinstance(x, (int, float)) for x in numbers)

def postcondition(input_args, output):
    if not isinstance(output, (int, float)):
        return False
    if output < 0:
        return False
    numbers = input_args[0]
    n = len(numbers)
    mean = sum(numbers) / n
    expected_mad = sum(abs(x - mean) for x in numbers) / n
    
    # Use a small epsilon for floating point comparison
    return abs(output - expected_mad) < 1e-9 or abs(output - expected_mad) / (abs(expected_mad) + 1e-9) < 1e-9

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
