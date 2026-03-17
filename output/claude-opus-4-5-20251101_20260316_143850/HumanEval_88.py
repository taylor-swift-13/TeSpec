
def precondition(args):
    array = args[0]
    # Check that array is a list
    if not isinstance(array, list):
        return False
    # Check that all elements are non-negative integers
    for elem in array:
        if not isinstance(elem, int):
            return False
        if elem < 0:
            return False
    return True


def postcondition(args, output):
    array = args[0]
    # Check that output is a list
    if not isinstance(output, list):
        return False
    # Check that output has the same length as input
    if len(output) != len(array):
        return False
    # Check that output is a permutation of input (same elements)
    if sorted(output) != sorted(array):
        return False
    # Check that original array is not modified (output should be a copy)
    # We can't fully verify this, but we can check output is sorted correctly
    
    # Empty or single element array should return as-is (sorted)
    if len(array) <= 1:
        return output == list(array)
    
    # Check sorting order based on sum of first and last element
    first_val = array[0]
    last_val = array[-1]
    total = first_val + last_val
    
    if total % 2 == 1:
        # Odd sum: ascending order
        for i in range(len(output) - 1):
            if output[i] > output[i + 1]:
                return False
    else:
        # Even sum: descending order
        for i in range(len(output) - 1):
            if output[i] < output[i + 1]:
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
