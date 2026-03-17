
def precondition(inp):
    try:
        arr = inp[0]
        return isinstance(arr, list) and all(isinstance(x, int) for x in arr)
    except Exception:
        return False

def postcondition(inp, out):
    try:
        arr = inp[0]
        expected = sum(1 for i in range(len(arr) // 2) if arr[i] != arr[~i])
        return isinstance(out, int) and not isinstance(out, bool) and out == expected
    except Exception:
        return False

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
