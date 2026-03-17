
def precondition(input):
    # Check that input is a tuple with exactly one argument
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    arr = input[0]
    
    # Check that arr is a list
    if not isinstance(arr, list):
        return False
    
    # Check that all elements are integers or floats (comparable numbers)
    for elem in arr:
        if not isinstance(elem, (int, float)):
            return False
        # Exclude boolean since bool is subclass of int
        if isinstance(elem, bool):
            return False
    
    # Check that there are no duplicate values
    if len(arr) != len(set(arr)):
        return False
    
    return True


def postcondition(input, output):
    arr = input[0]
    
    # Output must be an integer
    if not isinstance(output, int):
        return False
    
    # Exclude boolean
    if isinstance(output, bool):
        return False
    
    # Output must be -1 or a valid index (1 to len(arr)-1)
    # Index 0 cannot be returned since there's no preceding element
    if output != -1 and (output < 1 or output >= len(arr)):
        return False
    
    # If output is -1, verify no element violates the condition
    if output == -1:
        for i in range(1, len(arr)):
            if arr[i] < arr[i - 1]:
                return False
        return True
    
    # If output is a valid index, verify:
    # 1. The element at output is not >= the element immediately preceding it
    #    (i.e., arr[output] < arr[output - 1])
    if arr[output] >= arr[output - 1]:
        return False
    
    # 2. It's the largest such index (no index greater than output has this property)
    for i in range(output + 1, len(arr)):
        if arr[i] < arr[i - 1]:
            return False
    
    return True

def _impl(arr):
    """Create a function which returns the largest index of an element which
    is not greater than or equal to the element immediately preceding it. If
    no such element exists then return -1. The given array will not contain
    duplicate values.

    Examples:
    can_arrange([1,2,4,3,5]) = 3
    can_arrange([1,2,3]) = -1"""
    for i in range(len(arr) - 1, 0, -1):
        if not (arr[i] >= arr[i - 1]):
            return i
    return -1

def can_arrange(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
