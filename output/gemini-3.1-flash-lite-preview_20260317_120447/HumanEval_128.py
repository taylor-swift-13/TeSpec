
def precondition(input):
    arr = input[0]
    return isinstance(arr, list)

def postcondition(input, output):
    arr = input[0]
    if not arr:
        return output is None
    
    import math
    
    def get_sign(n):
        if n > 0: return 1
        if n < 0: return -1
        return 0
    
    sum_magnitudes = sum(abs(x) for x in arr)
    product_signs = 1
    for x in arr:
        product_signs *= get_sign(x)
        
    expected = sum_magnitudes * product_signs
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
