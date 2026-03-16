from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    numbers = input[0]
    if not isinstance(numbers, (list, tuple)):
        return False
    if len(numbers) < 2:
        return False
    import math
    has_number = False
    for x in numbers:
        # exclude booleans which are subclasses of int
        if isinstance(x, bool):
            return False
        if not isinstance(x, (int, float)):
            return False
        if math.isnan(x) or math.isinf(x):
            return False
        has_number = True
    if not has_number:
        return False
    try:
        mn = min(numbers)
        mx = max(numbers)
    except Exception:
        return False
    # require a non-zero range so linear mapping to [0,1] is defined
    if not (mx > mn):
        return False
    return True

def postcondition(input, output):
    # If precondition not met, do not assert postcondition here
    if not precondition(input):
        return True
    numbers = input[0]
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(numbers):
        return False
    import math
    try:
        mn = min(numbers)
        mx = max(numbers)
    except Exception:
        return False
    denom = mx - mn
    if denom == 0:
        return False
    tol = 1e-9
    for i, (x, y) in enumerate(zip(numbers, output)):
        # output elements should be numeric (not bool) and finite
        if isinstance(y, bool):
            return False
        if not isinstance(y, (int, float)):
            return False
        if math.isnan(y) or math.isinf(y):
            return False
        expected = (x - mn) / denom
        if not (abs(y - expected) <= tol):
            return False
        # also ensure in [0,1] within tolerance
        if y < -tol or y > 1.0 + tol:
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
