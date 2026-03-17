
def precondition(args) -> bool:
    arr = args[0]
    
    # Check that arr is a list
    if not isinstance(arr, list):
        return False
    
    # Check length constraint (allowing empty based on examples, though constraint says >= 1)
    # Being conservative: allow empty arrays since Example 3 shows empty input
    if len(arr) > 10000:
        return False
    
    # Check all elements are non-negative integers
    for elem in arr:
        if not isinstance(elem, int):
            return False
        if isinstance(elem, bool):  # bool is subclass of int in Python
            return False
        if elem < 0:
            return False
    
    return True


def postcondition(args, output) -> bool:
    arr = args[0]
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # Find all even values in the array
    even_values = [(val, idx) for idx, val in enumerate(arr) if val % 2 == 0]
    
    # If no even values or empty array, output should be empty list
    if len(even_values) == 0:
        return output == []
    
    # Otherwise, output should be [smallest_even_value, its_index]
    if len(output) != 2:
        return False
    
    result_value, result_index = output
    
    # Check that result_index is valid
    if not isinstance(result_index, int) or result_index < 0 or result_index >= len(arr):
        return False
    
    # Check that result_value matches the value at result_index
    if arr[result_index] != result_value:
        return False
    
    # Check that result_value is even
    if result_value % 2 != 0:
        return False
    
    # Find the smallest even value
    min_even = min(val for val, idx in even_values)
    
    # Check that result_value is the smallest even value
    if result_value != min_even:
        return False
    
    # Find the smallest index among nodes with the smallest even value
    min_index = min(idx for val, idx in even_values if val == min_even)
    
    # Check that result_index is the smallest index for the smallest even value
    if result_index != min_index:
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
