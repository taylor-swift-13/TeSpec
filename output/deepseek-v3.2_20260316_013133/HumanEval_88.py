
def precondition(input):
    array, = input
    if not isinstance(array, list):
        return False
    for x in array:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True

def postcondition(input, output):
    array, = input
    if not isinstance(output, list):
        return False
    if len(output) != len(array):
        return False
    if sorted(array) != sorted(output):
        return False
    if len(array) == 0:
        return output == []
    if len(array) == 1:
        return output == array
    first = array[0]
    last = array[-1]
    sum_fl = first + last
    if sum_fl % 2 == 1:
        return output == sorted(array)
    else:
        return output == sorted(array, reverse=True)

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
