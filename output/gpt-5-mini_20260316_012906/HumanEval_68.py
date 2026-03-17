
def precondition(input):
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        arr = input[0]
        if not isinstance(arr, (list, tuple)):
            return False
        if len(arr) > 10000:
            return False
        # allow empty list
        for x in arr:
            # reject booleans explicitly
            if isinstance(x, bool):
                return False
            if not isinstance(x, int):
                return False
            if x < 0:
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        # Basic input validation
        if not (isinstance(input, tuple) and len(input) == 1):
            return False
        arr = input[0]
        if not isinstance(arr, (list, tuple)):
            return False

        # Compute expected result
        min_even = None
        min_index = None
        for i, v in enumerate(arr):
            # skip non-ints or negatives (should be ruled out by precondition)
            if not isinstance(v, int):
                return False
            if v % 2 == 0:
                if min_even is None or v < min_even:
                    min_even = v
                    min_index = i

        if min_even is None:
            # expected empty list
            return output == []
        # expected a list [min_even, min_index]
        if not isinstance(output, list):
            return False
        if len(output) != 2:
            return False
        val, idx = output[0], output[1]
        # types and bounds
        if not isinstance(val, int) or isinstance(val, bool):
            return False
        if not isinstance(idx, int) or isinstance(idx, bool):
            return False
        if idx < 0 or idx >= len(arr):
            return False
        if val != arr[idx]:
            return False
        if val % 2 != 0:
            return False
        if val != min_even:
            return False
        # ensure that the reported index is the first occurrence of that minimal even value
        for i in range(0, idx):
            if arr[i] == min_even:
                return False
        return True
    except Exception:
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
