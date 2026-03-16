from typing import List

def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        numbers = input[0]
        if not isinstance(numbers, (list, tuple)):
            return False
        if len(numbers) < 1:
            return False
        for x in numbers:
            if not isinstance(x, (int, float)):
                return False
            if not (x == x) or x == float('inf') or x == float('-inf'):
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return True
        numbers = input[0]
        n = len(numbers)
        s = 0.0
        for x in numbers:
            s += float(x)
        mean = s / n
        total = 0.0
        for x in numbers:
            total += abs(float(x) - mean)
        expected = total / n
        if not isinstance(output, (int, float)):
            return False
        if not (output == output) or output == float('inf') or output == float('-inf'):
            return False
        a = float(output)
        b = expected
        diff = abs(a - b)
        maxab = max(abs(a), abs(b))
        rel_tol = 1e-9
        abs_tol = 1e-12
        close = diff <= (rel_tol * maxab if rel_tol * maxab > abs_tol else abs_tol)
        nonneg = a >= -1e-12
        return close and nonneg
    except Exception:
        return False

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
