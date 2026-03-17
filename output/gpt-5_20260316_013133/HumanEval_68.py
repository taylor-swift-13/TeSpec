
def precondition(input):
    if not (isinstance(input, tuple) and len(input) == 1):
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    arr = input[0]
    if not isinstance(output, list):
        return False
    evens = [x for x in arr if x % 2 == 0]
    if not evens:
        return output == []
    mn = min(evens)
    idx = None
    for i, v in enumerate(arr):
        if v == mn:
            idx = i
            break
    if idx is None:
        return False
    if not (len(output) == 2 and isinstance(output[0], int) and isinstance(output[1], int)):
        return False
    if not (0 <= output[1] < len(arr)):
        return False
    if output[0] != mn or output[1] != idx:
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
