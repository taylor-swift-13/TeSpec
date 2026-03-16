
def precondition(args):
    arr = args[0]
    if not isinstance(arr, list):
        return False
    if len(arr) == 0:
        return True
    if not all(isinstance(x, (int, float)) for x in arr):
        return False
    if len(set(arr)) != len(arr):
        return False
    return True

def postcondition(args, result):
    arr = args[0]
    if not isinstance(result, int):
        return False
    if result == -1:
        for i in range(1, len(arr)):
            if arr[i] < arr[i-1]:
                return False
        return True
    if result < 1 or result >= len(arr):
        return False
    if arr[result] >= arr[result-1]:
        return False
    for i in range(1, result):
        if arr[i] < arr[i-1]:
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
