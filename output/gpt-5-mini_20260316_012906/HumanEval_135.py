
def precondition(inp):
    if not isinstance(inp, tuple):
        return False
    if len(inp) != 1:
        return False
    arr = inp[0]
    if not isinstance(arr, (list, tuple)):
        return False
    # ensure adjacent elements are comparable using >= and <
    try:
        for i in range(1, len(arr)):
            _ = arr[i] >= arr[i-1]
            _ = arr[i] < arr[i-1]
    except Exception:
        return False
    return True

def postcondition(inp, output):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    arr = inp[0]
    if not isinstance(arr, (list, tuple)):
        return False
    if not isinstance(output, int):
        return False
    n = len(arr)
    # valid result -1 means no index i>=1 with arr[i] < arr[i-1]
    if output == -1:
        try:
            for i in range(1, n):
                if arr[i] < arr[i-1]:
                    return False
        except Exception:
            return False
        return True
    # otherwise output must be a valid index with a preceding element
    if not (1 <= output < n):
        return False
    try:
        if not (arr[output] < arr[output-1]):
            return False
    except Exception:
        return False
    # it must be the largest such index: no later index has arr[j] < arr[j-1]
    try:
        for j in range(output+1, n):
            if arr[j] < arr[j-1]:
                return False
    except Exception:
        return False
    return True

def _impl(arr):
    """Create a function which returns the largest index of an element which
    is not greater than or equal to the element immediately preceding it. If
    no such element exists then return -1. The given array will not contain
    duplicate values.

    Examples:
    can_arrange([1,2,4,3,5]) = 3
    can_arrange([1,2,3]) = -1"""
    for i in range(len(arr) - 1, 0, -1):
        if not (arr[i] >= arr[i - 1]):
            return i
    return -1

def can_arrange(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
