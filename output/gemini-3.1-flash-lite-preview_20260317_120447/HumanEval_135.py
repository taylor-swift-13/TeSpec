
def precondition(input):
    arr = input[0]
    if not isinstance(arr, list):
        return False
    return all(isinstance(x, (int, float)) for x in arr)

def postcondition(input, output):
    arr = input[0]
    if output == -1:
        for i in range(1, len(arr)):
            if arr[i] < arr[i-1]:
                return False
        return True
    else:
        if not (0 <= output < len(arr)):
            return False
        if arr[output] >= arr[output-1]:
            return False
        for i in range(output + 1, len(arr)):
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
