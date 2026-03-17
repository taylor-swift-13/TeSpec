
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    arr = args[0]
    # arr should be a list (or None is returned for empty)
    if not isinstance(arr, (list, tuple)):
        return False
    # Each element should be an integer
    for x in arr:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True


def postcondition(input, output):
    arr = input[0]
    
    # Empty array should return None
    if len(arr) == 0:
        return output is None
    
    # If any element is 0, the product of signs is 0, so result should be 0
    if any(x == 0 for x in arr):
        return output == 0
    
    # Compute expected result
    sum_magnitudes = sum(abs(x) for x in arr)
    
    product_signs = 1
    for x in arr:
        if x > 0:
            product_signs *= 1
        elif x < 0:
            product_signs *= -1
        else:
            product_signs = 0
    
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
