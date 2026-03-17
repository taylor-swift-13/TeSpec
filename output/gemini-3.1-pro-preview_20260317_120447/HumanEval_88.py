
def precondition(inp):
    if len(inp) != 1:
        return False
    array = inp[0]
    if not isinstance(array, list):
        return False
    if not all(isinstance(x, int) and x >= 0 for x in array):
        return False
    return True

def postcondition(inp, out):
    array = inp[0]
    if not isinstance(out, list):
        return False
    if len(array) == 0:
        return out == []
    if (array[0] + array[-1]) % 2 != 0:
        return out == sorted(array)
    return out == sorted(array, reverse=True)

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
