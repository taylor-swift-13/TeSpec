
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    try:
        for x in arr:
            if not isinstance(x, int):
                return False
            if x < 0:
                return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    # output should be a sequence (list or tuple) and not the same object as input
    if output is arr:
        return False
    try:
        n_in = len(arr)
        n_out = len(output)
    except Exception:
        return False
    if n_in != n_out:
        return False
    # Check multiset equality of elements
    counts_in = {}
    for x in arr:
        counts_in[x] = counts_in.get(x, 0) + 1
    counts_out = {}
    for y in output:
        counts_out[y] = counts_out.get(y, 0) + 1
    if counts_in != counts_out:
        return False
    # Determine required order based on parity when possible and check ordering
    if n_in >= 1:
        try:
            s = arr[0] + arr[-1]
        except Exception:
            return False
        if s % 2 == 1:
            # should be non-decreasing (ascending)
            for i in range(n_out - 1):
                try:
                    if output[i] > output[i + 1]:
                        return False
                except Exception:
                    return False
        else:
            # should be non-increasing (descending)
            for i in range(n_out - 1):
                try:
                    if output[i] < output[i + 1]:
                        return False
                except Exception:
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
