
def precondition(input):
    arr, k = input
    if not isinstance(arr, list):
        return False
    if not isinstance(k, int):
        return False
    if len(arr) < 1 or len(arr) > 1000:
        return False
    if not all(isinstance(x, int) and -1000 <= x <= 1000 for x in arr):
        return False
    if k < 0 or k > len(arr):
        return False
    return True


def postcondition(input, output):
    arr, k = input
    if not isinstance(output, list):
        return False
    if len(output) != k:
        return False
    # Output must be sorted in non-decreasing order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    # The output should contain the k largest elements from arr
    # Check that sorted output equals the k largest elements sorted
    sorted_arr = sorted(arr)
    expected = sorted_arr[len(arr) - k:]
    if output != expected:
        return False
    return True

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
