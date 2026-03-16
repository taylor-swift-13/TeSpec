
def precondition(input):
    # input should be a tuple with a single element: the array
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    # elements must be non-negative integers
    for v in arr:
        if not isinstance(v, int) or v < 0:
            return False
    return True

def postcondition(input, output):
    # input should be a tuple with a single element: the array
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, list):
        return False
    if not isinstance(output, list):
        return False

    # determine expected output without modifying input
    if len(arr) == 0:
        expected = []
    elif (arr[0] + arr[-1]) % 2 == 1:
        expected = sorted(arr)
    else:
        expected = sorted(arr, reverse=True)

    if output != expected:
        return False

    # ensure a copy is returned (not the same object as input array)
    if output is arr:
        return False

    return True

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
