
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
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
        return True
    arr = input[0]
    if len(arr) == 0:
        return output is None
    sign_prod = 1
    total_abs = 0
    for x in arr:
        if x > 0:
            s = 1
        elif x < 0:
            s = -1
        else:
            s = 0
        sign_prod *= s
        total_abs += abs(x)
    expected = sign_prod * total_abs
    return isinstance(output, int) and output == expected

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
