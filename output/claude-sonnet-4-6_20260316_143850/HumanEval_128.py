
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, (int, float)):
            return False
    return True


def postcondition(input, output) -> bool:
    arr = input[0]
    if len(arr) == 0:
        return output is None
    if output is None:
        return False
    if not isinstance(output, (int, float)):
        return False
    sum_magnitudes = sum(abs(x) for x in arr)
    has_zero = any(x == 0 for x in arr)
    if has_zero:
        return output == 0
    negatives = sum(1 for x in arr if x < 0)
    sign = 1 if negatives % 2 == 0 else -1
    return output == sign * sum_magnitudes

def _impl(arr):
    """You are given an array arr of integers and you need to return
    sum of magnitudes of integers multiplied by product of all signs
    of each number in the array, represented by 1, -1 or 0.
    Note: return None for empty arr.

    Example:"""
    if arr == []: return None
    if 0 in arr: return 0
    s, sgn = 0, 1
    for x in arr:
        s += abs(x)
        sgn *= (x // abs(x))
    return s * sgn

def prod_signs(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
