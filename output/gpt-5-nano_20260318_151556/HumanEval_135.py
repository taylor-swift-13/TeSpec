
def precondition(input):
    # input should be a tuple with a single argument: arr
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    return True

def postcondition(input, output):
    # Validate input shape
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    # Validate output type
    if not isinstance(output, int):
        return False
    # Compute expected result
    n = len(arr)
    expected = -1
    for i in range(1, n):
        try:
            if arr[i] < arr[i - 1]:
                expected = i
        except Exception:
            return False
    return output == expected

def _impl(arr):
    """
    Create a function which returns the largest index of an element which
    is not greater than or equal to the element immediately preceding it. If
    no such element exists then return -1. The given array will not contain
    duplicate values.

    Examples:
    can_arrange([1,2,4,3,5]) = 3
    can_arrange([1,2,3]) = -1
    """
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
