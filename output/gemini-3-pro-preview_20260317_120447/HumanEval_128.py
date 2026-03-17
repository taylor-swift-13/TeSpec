
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    arr = input_args[0]
    return isinstance(arr, (list, tuple)) and all(isinstance(x, int) for x in arr)

def postcondition(input_args, output):
    arr = input_args[0]
    if not arr:
        return output is None
    
    sum_magnitudes = sum(abs(x) for x in arr)
    product_signs = 1
    for x in arr:
        if x == 0:
            product_signs = 0
            break
        elif x < 0:
            product_signs *= -1
            
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
