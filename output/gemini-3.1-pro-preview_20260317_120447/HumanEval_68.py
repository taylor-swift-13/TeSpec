
def precondition(inp) -> bool:
    if len(inp) != 1:
        return False
    arr = inp[0]
    if not isinstance(arr, list):
        return False
    return all(isinstance(x, int) and not isinstance(x, bool) and x >= 0 for x in arr)

def postcondition(inp, out) -> bool:
    arr = inp[0]
    if not isinstance(out, list):
        return False
    if len(out) == 0:
        return all(x % 2 != 0 for x in arr)
    if len(out) == 2:
        val, idx = out
        if not isinstance(val, int) or isinstance(val, bool):
            return False
        if not isinstance(idx, int) or isinstance(idx, bool):
            return False
        if val % 2 != 0:
            return False
        if idx < 0 or idx >= len(arr):
            return False
        if arr[idx] != val:
            return False
        evens = [x for x in arr if x % 2 == 0]
        if not evens:
            return False
        if val != min(evens):
            return False
        if arr.index(val) != idx:
            return False
        return True
    return False

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
