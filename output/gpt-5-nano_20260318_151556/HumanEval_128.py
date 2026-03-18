
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if type(x) is not int:
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    if len(arr) == 0:
        expected = None
    else:
        sign_prod = 1
        for a in arr:
            if a == 0:
                sign_prod = 0
                break
            sign_prod *= (1 if a > 0 else -1)
        expected = sum(abs(a) for a in arr) * sign_prod
    return output == expected

def _impl(arr):
    """
    You are given an array arr of integers and you need to return
    sum of magnitudes of integers multiplied by product of all signs
    of each number in the array, represented by 1, -1 or 0.
    Note: return None for empty arr.

    Example:
    """
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
