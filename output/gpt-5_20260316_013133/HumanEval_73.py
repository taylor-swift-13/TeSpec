
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    try:
        n = len(arr)
    except Exception:
        return False
    try:
        if n > 0:
            _ = arr[0]
            _ = arr[n - 1]
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    arr = input[0]
    try:
        n = len(arr)
    except Exception:
        return False
    mismatches = 0
    try:
        for i in range(n // 2):
            if arr[i] != arr[n - 1 - i]:
                mismatches += 1
    except Exception:
        return False
    if not isinstance(output, int):
        return False
    return output == mismatches

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
