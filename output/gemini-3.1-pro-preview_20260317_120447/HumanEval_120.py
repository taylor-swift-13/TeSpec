
def precondition(inp) -> bool:
    try:
        arr, k = inp
        if not isinstance(arr, list):
            return False
        if not isinstance(k, int):
            return False
        if not (1 <= len(arr) <= 1000):
            return False
        if not (0 <= k <= len(arr)):
            return False
        if not all(isinstance(x, int) and -1000 <= x <= 1000 for x in arr):
            return False
        return True
    except Exception:
        return False

def postcondition(inp, out) -> bool:
    try:
        arr, k = inp
        if not isinstance(out, list):
            return False
        if len(out) != k:
            return False
        expected = sorted(arr)[len(arr)-k:]
        return out == expected
    except Exception:
        return False

def _impl(arr, k):
    """Given an array arr of integers and a positive integer k, return a sorted list 
    of length k with the maximum k numbers in arr.

    Example 1:

        Input: arr = [-3, -4, 5], k = 3
        Output: [-4, -3, 5]

    Example 2:

        Input: arr = [4, -4, 4], k = 2
        Output: [4, 4]

    Example 3:

        Input: arr = [-3, 2, 1, 2, -1, -2, 1], k = 1
        Output: [2]

    Note:
        1. The length of the array will be in the range of [1, 1000].
        2. The elements in the array will be in the range of [-1000, 1000].
        3. 0 <= k <= len(arr)"""
    return sorted(sorted(arr)[::-1][:k])

def maximum(arr, k):
    _input = (arr, k)
    assert precondition(_input)
    _output = _impl(arr, k)
    assert postcondition(_input, _output)
    return _output
