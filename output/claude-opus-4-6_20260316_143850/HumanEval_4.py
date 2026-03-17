from typing import List

def precondition(input):
    numbers = input[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) == 0:
        return False
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    return True


def postcondition(input, output):
    numbers = input[0]
    if not isinstance(output, (int, float)):
        return False
    if output < 0:
        return False
    # MAD is zero if and only if all elements are the same
    all_same = all(n == numbers[0] for n in numbers)
    if all_same and abs(output) > 1e-9:
        return False
    if not all_same and output <= 0:
        return False
    # Verify MAD computation
    mean = sum(numbers) / len(numbers)
    expected = sum(abs(x - mean) for x in numbers) / len(numbers)
    if abs(output - expected) > 1e-6:
        return False
    # MAD cannot exceed the range of the data divided by 2 (roughly)
    max_val = max(numbers)
    min_val = min(numbers)
    if output > (max_val - min_val):
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
