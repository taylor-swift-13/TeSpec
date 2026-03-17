
def precondition(args) -> bool:
    # Unpack the single argument
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    
    arr = args[0]
    
    # arr must be a list
    if not isinstance(arr, list):
        return False
    
    # All elements must be integers
    for elem in arr:
        if not isinstance(elem, int) or isinstance(elem, bool):
            return False
    
    return True


def postcondition(args, output) -> bool:
    arr = args[0]
    
    # Output must be a non-negative integer
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    
    if output < 0:
        return False
    
    n = len(arr)
    
    # Output cannot exceed half the length (rounded down)
    # since we only need to change at most one element per pair
    if output > n // 2:
        return False
    
    # Count the number of mismatched pairs
    mismatches = 0
    for i in range(n // 2):
        if arr[i] != arr[n - 1 - i]:
            mismatches += 1
    
    # The minimum changes needed equals the number of mismatched pairs
    if output != mismatches:
        return False
    
    return True

def _impl(arr):
    """Given an array arr of integers, find the minimum number of elements that
    need to be changed to make the array palindromic. A palindromic array is an array that
    is read the same backwards and forwards. In one change, you can change one element to any other element.

    For example:
    smallest_change([1,2,3,5,4,7,9,6]) == 4
    smallest_change([1, 2, 3, 4, 3, 2, 2]) == 1
    smallest_change([1, 2, 3, 2, 1]) == 0"""
    arr_reversed, cnt = arr[::-1], 0
    for i in range(len(arr) // 2):
        if arr[i] != arr_reversed[i]:
            cnt += 1
    return cnt

def smallest_change(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
