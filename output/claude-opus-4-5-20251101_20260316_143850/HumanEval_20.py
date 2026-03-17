from typing import List, Tuple

def precondition(input):
    numbers = input[0]
    # Check that numbers is a list
    if not isinstance(numbers, list):
        return False
    # Check that the list has at least two elements
    if len(numbers) < 2:
        return False
    # Check that all elements are numbers (int or float)
    for n in numbers:
        if not isinstance(n, (int, float)):
            return False
    return True


def postcondition(input, output):
    numbers = input[0]
    # Check that output is a tuple of two elements
    if not isinstance(output, tuple):
        return False
    if len(output) != 2:
        return False
    a, b = output
    # Check that both elements are numbers
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return False
    # Check that output is in order (smaller, larger)
    if a > b:
        return False
    # Check that both output values exist in the input list
    numbers_copy = list(numbers)
    try:
        numbers_copy.remove(a)
        numbers_copy.remove(b)
    except ValueError:
        return False
    # Calculate the distance of the output pair
    output_distance = b - a
    # Check that no other pair has a smaller distance
    sorted_numbers = sorted(numbers)
    for i in range(len(sorted_numbers) - 1):
        pair_distance = sorted_numbers[i + 1] - sorted_numbers[i]
        if pair_distance < output_distance:
            return False
    return True

def _impl(numbers: List[float]) -> Tuple[float, float]:
    """From a supplied list of numbers (of length at least two) select and return two that are the closest to each
    other and return them in order (smaller number, larger number).
    (2.0, 2.2)
    (2.0, 2.0)"""
    numbers.sort()
    min_diff = float("inf")
    min_pair = None
    for l, r in zip(numbers[:-1], numbers[1:]):
        diff = r - l
        if diff < min_diff:
            min_diff = diff
            min_pair = (l, r)
    return min_pair

def find_closest_elements(numbers: List[float]) -> Tuple[float, float]:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
