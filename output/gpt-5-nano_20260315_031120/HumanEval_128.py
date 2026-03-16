
def precondition(input):
    # Expect a single positional argument: a list or tuple of integers (can be empty)
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
    # Validate structure
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False

    # Empty array should yield None
    if len(arr) == 0:
        return output is None

    # Non-empty: output must be an int
    if not isinstance(output, int):
        return False

    # Compute expected value: sum(abs(x)) * product(sign(x))
    sign_product = 1
    mag_sum = 0
    for x in arr:
        if x > 0:
            s = 1
        elif x < 0:
            s = -1
        else:
            s = 0
        sign_product *= s
        mag_sum += abs(x)

    expected = mag_sum * sign_product
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
