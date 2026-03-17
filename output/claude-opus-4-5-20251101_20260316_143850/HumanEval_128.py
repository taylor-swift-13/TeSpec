
def precondition(input):
    # Check that input is a tuple with exactly one argument
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    arr = input[0]
    
    # arr should be a list
    if not isinstance(arr, list):
        return False
    
    # All elements in arr should be integers
    for item in arr:
        if not isinstance(item, int) or isinstance(item, bool):
            return False
    
    return True


def postcondition(input, output):
    arr = input[0]
    
    # For empty array, return None
    if len(arr) == 0:
        return output is None
    
    # For non-empty array, output should be an integer
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    
    # Calculate expected result
    # Sum of magnitudes
    sum_magnitudes = sum(abs(x) for x in arr)
    
    # Product of signs
    product_signs = 1
    for x in arr:
        if x > 0:
            product_signs *= 1
        elif x < 0:
            product_signs *= -1
        else:
            product_signs *= 0
    
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
