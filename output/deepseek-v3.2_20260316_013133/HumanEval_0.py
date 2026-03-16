from typing import List

def precondition(input):
    numbers, threshold = input
    if not isinstance(numbers, list):
        return False
    if not all(isinstance(x, (int, float)) for x in numbers):
        return False
    if not isinstance(threshold, (int, float)):
        return False
    if threshold < 0:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    numbers, threshold = input
    if not precondition(input):
        return False
    if len(numbers) < 2:
        return output == False
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            if abs(numbers[i] - numbers[j]) < threshold:
                return output == True
    return output == False

def _impl(numbers: List[float], threshold: float) -> bool:
    """Check if in given list of numbers, are any two numbers closer to each other than
    given threshold.
    False
    True"""
    sorted_numbers = sorted(numbers)
    for i in range(len(sorted_numbers) - 1):
        if sorted_numbers[i + 1] - sorted_numbers[i] < threshold:
            return True
    return False

def has_close_elements(numbers: List[float], threshold: float) -> bool:
    _input = (numbers, threshold)
    assert precondition(_input)
    _output = _impl(numbers, threshold)
    assert postcondition(_input, _output)
    return _output
