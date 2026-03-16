from typing import List, Tuple

def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        numbers = input[0]
        if not hasattr(numbers, "__len__"):
            return False
        if len(numbers) < 2:
            return False
        import math
        for x in numbers:
            if not isinstance(x, (int, float)):
                return False
            if isinstance(x, float) and not math.isfinite(x):
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return True
        numbers = input[0]
        if not (isinstance(output, (tuple, list)) and len(output) == 2):
            return False
        import math
        a, b = output[0], output[1]
        if not isinstance(a, (int, float)) or not isinstance(b, (int, float)):
            return False
        if (isinstance(a, float) and not math.isfinite(a)) or (isinstance(b, float) and not math.isfinite(b)):
            return False
        if a > b:
            return False
        def count_val(seq, v):
            c = 0
            for x in seq:
                if x == v:
                    c += 1
            return c
        if a == b:
            if count_val(numbers, a) < 2:
                return False
        else:
            if count_val(numbers, a) < 1 or count_val(numbers, b) < 1:
                return False
        nums = list(numbers)
        n = len(nums)
        min_diff = None
        for i in range(n):
            xi = nums[i]
            for j in range(i + 1, n):
                yj = nums[j]
                d = abs(xi - yj)
                if min_diff is None or d < min_diff:
                    min_diff = d
        sel_diff = abs(a - b)
        if not math.isclose(sel_diff, min_diff, rel_tol=1e-12, abs_tol=1e-12):
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
