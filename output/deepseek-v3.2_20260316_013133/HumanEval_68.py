
def precondition(args):
    arr = args[0]
    if not isinstance(arr, list):
        return False
    if not (0 <= len(arr) <= 10000):
        return False
    for item in arr:
        if not isinstance(item, int):
            return False
        if item < 0:
            return False
    return True

def postcondition(args, result):
    arr = args[0]
    if not isinstance(result, list):
        return False
    if len(arr) == 0:
        return result == []
    if len(result) != 2:
        return False
    if not isinstance(result[0], int) or not isinstance(result[1], int):
        return False
    if result[1] < 0 or result[1] >= len(arr):
        return False
    if arr[result[1]] != result[0]:
        return False
    if result[0] % 2 != 0:
        return False
    for i, val in enumerate(arr):
        if val % 2 == 0:
            if val < result[0]:
                return False
            if val == result[0] and i < result[1]:
                return False
    return True

def _impl(arr):
    """
    "Given an array representing a branch of a tree that has non-negative integer nodes
    your task is to pluck one of the nodes and return it.
    The plucked node should be the node with the smallest even value.
    If multiple nodes with the same smallest even value are found return the node that has smallest index.

    The plucked node should be returned in a list, [ smalest_value, its index ],
    If there are no even values or the given array is empty, return [].

    Example 1:
        Input: [4,2,3]
        Output: [2, 1]
        Explanation: 2 has the smallest even value, and 2 has the smallest index.

    Example 2:
        Input: [1,2,3]
        Output: [2, 1]
        Explanation: 2 has the smallest even value, and 2 has the smallest index. 

    Example 3:
        Input: []
        Output: []

    Example 4:
        Input: [5, 0, 3, 0, 4, 2]
        Output: [0, 1]
        Explanation: 0 is the smallest value, but  there are two zeros,
                     so we will choose the first zero, which has the smallest index.

    Constraints:
        * 1 <= nodes.length <= 10000
        * 0 <= node.value
    """
    if all(val % 2 == 1 for val in arr): return []
    min_even = min(filter(lambda x: x % 2 == 0, arr))
    for i in range(len(arr)):
        if arr[i] == min_even:
            return [min_even, i]

def pluck(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
