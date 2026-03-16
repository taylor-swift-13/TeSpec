
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True

def postcondition(input, output):
    # Basic shape checks
    if not isinstance(input, tuple) or len(input) < 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    if not isinstance(output, list):
        return False
    # Output must be a new list (a copy), not the same object
    if output is arr:
        return False
    # Length and multiset of elements must match
    if len(output) != len(arr):
        return False
    if sorted(output) != sorted(arr):
        return False
    # For empty input, expect empty output
    if len(arr) == 0:
        return output == []
    # Determine parity of sum of first and last elements
    try:
        s = arr[0] + arr[-1]
    except Exception:
        return False
    if s % 2 == 1:
        # odd -> ascending
        return output == sorted(arr)
    else:
        # even -> descending
        return output == sorted(arr, reverse=True)

def _impl(array):
    """Given an array of non-negative integers, return a copy of the given array after sorting,
    you will sort the given array in ascending order if the sum( first index value, last index value) is odd,
    or sort it in descending order if the sum( first index value, last index value) is even.

    Note:
    * don't change the given array.

    Examples:
    * sort_array([]) => []
    * sort_array([5]) => [5]
    * sort_array([2, 4, 3, 0, 1, 5]) => [0, 1, 2, 3, 4, 5]
    * sort_array([2, 4, 3, 0, 1, 5, 6]) => [6, 5, 4, 3, 2, 1, 0]"""
    if array == []: return []
    return sorted(array, reverse=(array[0]+array[-1]) % 2 == 0)

def sort_array(array):
    _input = (array,)
    assert precondition(_input)
    _output = _impl(array)
    assert postcondition(_input, _output)
    return _output
