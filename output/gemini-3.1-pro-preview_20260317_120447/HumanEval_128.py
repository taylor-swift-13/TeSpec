
def precondition(inputs):
    if len(inputs) != 1:
        return False
    arr = inputs[0]
    if not isinstance(arr, (list, tuple)):
        return False
    if not all(isinstance(x, int) for x in arr):
        return False
    return True

def postcondition(inputs, output):
    arr = inputs[0]
    if len(arr) == 0:
        return output is None
    
    sum_mag = sum(abs(x) for x in arr)
    prod_sign = 1
    for x in arr:
        if x > 0:
            prod_sign *= 1
        elif x < 0:
            prod_sign *= -1
        else:
            prod_sign *= 0
            
    expected = sum_mag * prod_sign
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
