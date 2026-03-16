from typing import List

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    if len(arr) < 2:
        return False
    for v in arr:
        if not isinstance(v, (int, float)):
            return False
    return True

def postcondition(input, output):
    EPS = 1e-9
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    if not isinstance(output, list):
        return False
    if len(output) != len(arr):
        return False
    for v in output:
        if not isinstance(v, (int, float)):
            return False
    min_v = min(arr)
    max_v = max(arr)
    if max_v > min_v:
        denom = max_v - min_v
        for i in range(len(arr)):
            expected = (arr[i] - min_v) / denom
            if abs(output[i] - expected) > EPS:
                return False
        if len(output) > 0:
            if abs(min(output) - 0.0) > EPS:
                return False
            if abs(max(output) - 1.0) > EPS:
                return False
        return True
    else:
        for v in output:
            if abs(v - 0.0) > EPS:
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
