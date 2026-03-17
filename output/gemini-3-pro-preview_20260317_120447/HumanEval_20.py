from typing import List, Tuple

def precondition(input_args: tuple) -> bool:
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    numbers = input_args[0]
    if not isinstance(numbers, list) or len(numbers) < 2:
        return False
    for x in numbers:
        if not isinstance(x, (int, float)):
            return False
    return True

def postcondition(input_args: tuple, output: tuple) -> bool:
    numbers = input_args[0]
    if not isinstance(output, tuple) or len(output) != 2:
        return False
    
    v1, v2 = output
    if v1 > v2:
        return False
    
    # Verify both elements exist in the original list at distinct indices
    temp_list = list(numbers)
    try:
        idx1 = -1
        for i, x in enumerate(temp_list):
            if x == v1:
                idx1 = i
                break
        if idx1 == -1: return False
        temp_list.pop(idx1)
        
        idx2 = -1
        for i, x in enumerate(temp_list):
            if x == v2:
                idx2 = i
                break
        if idx2 == -1: return False
    except (ValueError, IndexError):
        return False

    # Verify the difference is minimal
    min_diff = abs(v2 - v1)
    for i in range(len(numbers)):
        for j in range(i + 1, len(numbers)):
            if abs(numbers[i] - numbers[j]) < min_diff:
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
