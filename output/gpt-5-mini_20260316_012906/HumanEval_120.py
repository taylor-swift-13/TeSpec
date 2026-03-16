
def precondition(input):
    try:
        arr, k = input
    except Exception:
        return False
    # arr must be a list or tuple of ints, length in [1,1000]
    if not isinstance(arr, (list, tuple)):
        return False
    n = len(arr)
    if not isinstance(n, int) or n < 1 or n > 1000:
        return False
    # k must be int and 0 <= k <= n
    if not isinstance(k, int):
        return False
    if k < 0 or k > n:
        return False
    # elements must be ints in [-1000,1000]
    for x in arr:
        if not isinstance(x, int):
            return False
        if x < -1000 or x > 1000:
            return False
    return True

def postcondition(input, output):
    try:
        arr, k = input
    except Exception:
        return False
    # If precondition fails, we cannot assert correctness
    if not precondition(input):
        return False
    # output should be a list of length k
    if not isinstance(output, list):
        return False
    if len(output) != k:
        return False
    # expected top-k in non-decreasing order
    if k == 0:
        expected = []
    else:
        expected = sorted(arr)[len(arr)-k:]
    return output == expected

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
