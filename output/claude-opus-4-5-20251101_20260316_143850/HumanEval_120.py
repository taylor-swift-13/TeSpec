
def precondition(input):
    arr, k = input
    
    # Check arr is a list
    if not isinstance(arr, list):
        return False
    
    # Check all elements in arr are integers
    if not all(isinstance(x, int) for x in arr):
        return False
    
    # Check k is an integer
    if not isinstance(k, int):
        return False
    
    # Check length of array is in range [1, 1000]
    if not (1 <= len(arr) <= 1000):
        return False
    
    # Check elements are in range [-1000, 1000]
    if not all(-1000 <= x <= 1000 for x in arr):
        return False
    
    # Check 0 <= k <= len(arr)
    if not (0 <= k <= len(arr)):
        return False
    
    return True


def postcondition(input, output):
    arr, k = input
    
    # Check output is a list
    if not isinstance(output, list):
        return False
    
    # Check output has length k
    if len(output) != k:
        return False
    
    # Check all elements in output are integers
    if not all(isinstance(x, int) for x in output):
        return False
    
    # Check output is sorted in ascending order
    for i in range(len(output) - 1):
        if output[i] > output[i + 1]:
            return False
    
    # Check output contains the k maximum numbers from arr
    # Sort arr in descending order and take first k elements
    sorted_arr_desc = sorted(arr, reverse=True)
    top_k = sorted_arr_desc[:k]
    
    # The output should be the sorted version of top_k
    if sorted(output) != sorted(top_k):
        return False
    
    # Since output should be sorted ascending
    if output != sorted(top_k):
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
