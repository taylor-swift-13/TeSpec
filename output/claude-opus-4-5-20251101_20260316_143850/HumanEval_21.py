from typing import List

def precondition(input):
    numbers = input[0]
    # Must be a list
    if not isinstance(numbers, list):
        return False
    # Must have at least two elements
    if len(numbers) < 2:
        return False
    # All elements must be numbers (int or float)
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    # Must have at least two distinct values for linear transform
    if min(numbers) == max(numbers):
        return False
    return True


def postcondition(input, output):
    numbers = input[0]
    # Output must be a list
    if not isinstance(output, list):
        return False
    # Output must have same length as input
    if len(output) != len(numbers):
        return False
    # All output elements must be numbers
    for n in output:
        if not isinstance(n, (int, float)):
            return False
    # Minimum of output should be 0
    if abs(min(output) - 0.0) > 1e-9:
        return False
    # Maximum of output should be 1
    if abs(max(output) - 1.0) > 1e-9:
        return False
    # All values should be in [0, 1]
    for n in output:
        if n < -1e-9 or n > 1.0 + 1e-9:
            return False
    # The relative ordering should be preserved (linear transform preserves order)
    for i in range(len(numbers)):
        for j in range(len(numbers)):
            if numbers[i] < numbers[j] and output[i] >= output[j] + 1e-9:
                return False
            if numbers[i] > numbers[j] and output[i] <= output[j] - 1e-9:
                return False
            if abs(numbers[i] - numbers[j]) < 1e-12 and abs(output[i] - output[j]) > 1e-9:
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
