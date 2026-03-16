
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    arr = input[0]
    if len(arr) == 0:
        return output is None
    # compute expected value
    total_magnitude = 0
    prod_sign = 1
    for x in arr:
        total_magnitude += abs(x)
        if x > 0:
            s = 1
        elif x < 0:
            s = -1
        else:
            s = 0
        prod_sign *= s
    expected = total_magnitude * prod_sign
    if isinstance(output, bool):
        return False
    if not isinstance(output, int):
        return False
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
