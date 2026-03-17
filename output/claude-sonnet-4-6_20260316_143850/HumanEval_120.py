
def precondition(input) -> bool:
    try:
        arr, k = input
        if not isinstance(arr, list):
            return False
        if not isinstance(k, int):
            return False
        if len(arr) < 1 or len(arr) > 1000:
            return False
        if k < 0 or k > len(arr):
            return False
        for x in arr:
            if not isinstance(x, int):
                return False
            if x < -1000 or x > 1000:
                return False
        return True
    except:
        return False


def postcondition(input, output) -> bool:
    try:
        arr, k = input
        if not isinstance(output, list):
            return False
        if len(output) != k:
            return False
        # output must be sorted
        for i in range(len(output) - 1):
            if output[i] > output[i + 1]:
                return False
        # output elements must be a subset of arr (multiset)
        arr_copy = list(arr)
        for x in output:
            if x in arr_copy:
                arr_copy.remove(x)
            else:
                return False
        # output must contain the k largest elements
        remaining = list(arr_copy)
        for x in remaining:
            for y in output:
                if x > y:
                    return False
        return True
    except:
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
