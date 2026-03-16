
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        # require integers (exclude booleans)
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    arr = input[0]
    n = len(arr)
    # output must be an integer (exclude booleans) within valid range
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    if output < 0 or output > n // 2:
        return False
    # minimal changes is the count of mismatched symmetric pairs
    mismatches = 0
    for i in range(n // 2):
        if arr[i] != arr[n - 1 - i]:
            mismatches += 1
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
