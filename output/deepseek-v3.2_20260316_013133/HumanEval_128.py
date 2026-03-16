
def precondition(input):
    arr, = input
    if not isinstance(arr, list):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    arr, = input
    if not isinstance(arr, list):
        return False
    if len(arr) == 0:
        return output is None
    if output is None:
        return False
    if not isinstance(output, (int, float)):
        return False
    magnitude_sum = 0
    sign_product = 1
    for x in arr:
        magnitude_sum += abs(x)
        if x > 0:
            sign_product *= 1
        elif x < 0:
            sign_product *= -1
        else:
            sign_product *= 0
    expected = magnitude_sum * sign_product
    return output == expected

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
