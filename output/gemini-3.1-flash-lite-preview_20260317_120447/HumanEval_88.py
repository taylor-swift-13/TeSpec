
def precondition(input):
    arr = input[0]
    return isinstance(arr, list) and all(isinstance(x, int) and x >= 0 for x in arr)

def postcondition(input, output):
    arr = input[0]
    if not isinstance(output, list) or len(output) != len(arr):
        return False
    if not arr:
        return output == []
    
    s = arr[0] + arr[-1]
    if s % 2 != 0:
        return output == sorted(arr)
    else:
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
