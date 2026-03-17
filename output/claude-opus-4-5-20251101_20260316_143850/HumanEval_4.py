from typing import List

def precondition(input):
    numbers = input[0]
    # Check that numbers is a list
    if not isinstance(numbers, list):
        return False
    # Check that the list is not empty (need at least one element to compute mean)
    if len(numbers) == 0:
        return False
    # Check that all elements are numbers (int or float)
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    return True


def postcondition(input, output):
    numbers = input[0]
    # Output should be a number (int or float)
    if not isinstance(output, (int, float)):
        return False
    # MAD should be non-negative
    if output < 0:
        return False
    # Verify the MAD calculation
    mean = sum(numbers) / len(numbers)
    expected_mad = sum(abs(x - mean) for x in numbers) / len(numbers)
    # Allow small floating point tolerance
    if abs(output - expected_mad) > 1e-9:
        return False
    return True

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
