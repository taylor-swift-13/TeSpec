
def precondition(inputs: tuple) -> bool:
    if len(inputs) != 1:
        return False
    arr = inputs[0]
    if not isinstance(arr, list):
        return False
    if not all(isinstance(x, (int, float)) for x in arr):
        return False
    return True

def postcondition(inputs: tuple, output: int) -> bool:
    if len(inputs) != 1:
        return False
    arr = inputs[0]
    if not isinstance(output, int):
        return False
    if output == -1:
        return all(arr[i] >= arr[i-1] for i in range(1, len(arr)))
    if not (1 <= output < len(arr)):
        return False
    if arr[output] >= arr[output-1]:
        return False
    return all(arr[i] >= arr[i-1] for i in range(output + 1, len(arr)))

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
