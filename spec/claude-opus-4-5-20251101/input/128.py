def sign(x):
    """
    Returns the sign of an integer x: -1 if x < 0, 1 if x > 0, and 0 if x == 0.
    """
    if x < 0:
        return -1
    elif x > 0:
        return 1
    else:
        return 0

def abs(x):
    """
    Returns the absolute value of an integer x.
    """
    if x < 0:
        return -x
    else:
        return x

def sum_magnitudes(arr):
    """
    Returns the sum of the absolute values of all elements in the list arr.
    """
    res = 0
    for x in arr:
        res += abs(x)
    return res

def product_signs(arr):
    """
    Returns the product of the signs of all elements in the list arr.
    """
    res = 1
    for x in arr:
        res *= sign(x)
    return res

def contains_zero(arr):
    """
    Returns True if the list arr contains the integer 0, otherwise False.
    """
    for x in arr:
        if x == 0:
            return True
    return False

def prod_signs_spec(arr, result):
    """
    Specifies the expected result for the product of signs logic.
    If arr is empty, result must be None.
    If arr is not empty:
        - If arr contains 0, result must be 0.
        - Otherwise, result must be the product of sum_magnitudes and product_signs.
    """
    if not arr:
        return result is None
    else:
        if contains_zero(arr):
            return result == 0
        else:
            # result is expected to be an integer representing 'Some Z'
            return result == (sum_magnitudes(arr) * product_signs(arr))
