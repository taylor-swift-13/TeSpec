from typing import List, Tuple

def precondition(input) -> bool:
    try:
        numbers = input[0]
        if not isinstance(numbers, (list, tuple)):
            return False
        if len(numbers) < 2:
            return False
        for n in numbers:
            if not isinstance(n, (int, float)):
                return False
            if n != n:  # NaN check
                return False
        return True
    except Exception:
        return False


def postcondition(input, output) -> bool:
    try:
        numbers = input[0]
        if not isinstance(output, (list, tuple)):
            return False
        if len(output) != 2:
            return False
        a, b = output
        if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
            return False
        # smaller or equal first
        if a > b:
            return False
        # both elements must be in the input list
        nums = list(numbers)
        # check a is in nums
        found_a = False
        temp = nums[:]
        for i, n in enumerate(temp):
            if n == a:
                found_a = True
                temp.pop(i)
                break
        if not found_a:
            return False
        # check b is in remaining
        found_b = False
        for n in temp:
            if n == b:
                found_b = True
                break
        if not found_b:
            return False
        # check that the distance is minimal among all pairs
        min_dist = abs(b - a)
        for i in range(len(nums)):
            for j in range(i + 1, len(nums)):
                if abs(nums[i] - nums[j]) < min_dist - 1e-12:
                    return False
        return True
    except Exception:
        return False

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
