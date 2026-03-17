
def precondition(input):
    arr, k = input
    return (
        isinstance(arr, list) and
        all(isinstance(x, int) and -1000 <= x <= 1000 for x in arr) and
        1 <= len(arr) <= 1000 and
        isinstance(k, int) and
        0 <= k <= len(arr)
    )

def postcondition(input, output):
    arr, k = input
    if not isinstance(output, list) or len(output) != k:
        return False
    if output != sorted(output):
        return False
    
    temp_arr = list(arr)
    for val in output:
        if val in temp_arr:
            temp_arr.remove(val)
        else:
            return False
            
    remaining = sorted(temp_arr)
    return all(val <= min(output) for val in remaining) if remaining and output else True

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
