from typing import List, Tuple

def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    numbers = inputs[0]
    if not isinstance(numbers, list):
        return False
    if len(numbers) < 2:
        return False
    if not all(isinstance(x, (int, float)) for x in numbers):
        return False
    return True

def postcondition(inputs: tuple, output: tuple) -> bool:
    if not isinstance(output, (tuple, list)) or len(output) != 2:
        return False
    a, b = output
    if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
        return False
    if a > b:
        return False
    
    numbers = inputs[0]
    nums_copy = list(numbers)
    try:
        nums_copy.remove(a)
        nums_copy.remove(b)
    except ValueError:
        return False
        
    sorted_nums = sorted(numbers)
    min_diff = min(sorted_nums[i+1] - sorted_nums[i] for i in range(len(sorted_nums)-1))
    
    if (b - a) > min_diff + 1e-5:
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
