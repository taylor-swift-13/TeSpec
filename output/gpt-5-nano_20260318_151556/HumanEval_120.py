
def precondition(input):
    # input should be a tuple (arr, k)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    arr, k = input

    # arr must be a list of ints within [-1000, 1000], length 1..1000
    if not isinstance(arr, list):
        return False
    n = len(arr)
    if not (1 <= n <= 1000):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
        if x < -1000 or x > 1000:
            return False

    # k must be an int with 0 <= k <= len(arr)
    if not isinstance(k, int):
        return False
    if not (0 <= k <= n):
        return False

    return True

def postcondition(input, output):
    # input is expected to be the same (arr, k)
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    arr, k = input

    # output must be a list
    if not isinstance(output, list):
        return False

    # k should be int and within [0, len(arr)]
    if not isinstance(k, int):
        return False
    n = len(arr)
    if not (0 <= k <= n):
        return False

    # output length must be k
    if len(output) != k:
        return False

    # output must be sorted in non-decreasing order
    for i in range(1, len(output)):
        if output[i] < output[i - 1]:
            return False

    # elements should be ints
    for x in output:
        if not isinstance(x, int):
            return False

    # expected output: the last k elements of the sorted arr (ascending order)
    if k == 0:
        expected = []
    else:
        expected = sorted(arr)[-k:]

    if output != expected:
        return False

    return True

def _impl(arr, k):
    """
    Given an array arr of integers and a positive integer k, return a sorted list 
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
        3. 0 <= k <= len(arr)
    """
    return sorted(sorted(arr)[::-1][:k])

def maximum(arr, k):
    _input = (arr, k)
    assert precondition(_input)
    _output = _impl(arr, k)
    assert postcondition(_input, _output)
    return _output
