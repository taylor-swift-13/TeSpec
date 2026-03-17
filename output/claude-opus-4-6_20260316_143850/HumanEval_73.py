
def precondition(input):
    # input is a tuple of positional arguments: (arr,)
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
    return True


def postcondition(input, output):
    arr = input[0]
    n = len(arr)
    
    # Output must be a non-negative integer
    if not isinstance(output, int):
        return False
    if output < 0:
        return False
    
    # Upper bound: at most n // 2 changes needed (one per mismatched pair)
    if output > n // 2:
        return False
    
    # The number of mismatched pairs gives the exact answer
    mismatches = sum(1 for i in range(n // 2) if arr[i] != arr[n - 1 - i])
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
