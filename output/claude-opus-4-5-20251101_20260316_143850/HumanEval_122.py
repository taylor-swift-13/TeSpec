
def precondition(input):
    arr, k = input
    
    # Check arr is a list
    if not isinstance(arr, list):
        return False
    
    # Check arr is non-empty and has length between 1 and 100
    if not (1 <= len(arr) <= 100):
        return False
    
    # Check all elements in arr are integers
    if not all(isinstance(x, int) for x in arr):
        return False
    
    # Check k is an integer
    if not isinstance(k, int):
        return False
    
    # Check 1 <= k <= len(arr)
    if not (1 <= k <= len(arr)):
        return False
    
    return True


def postcondition(input, output):
    arr, k = input
    
    # Check output is an integer
    if not isinstance(output, int):
        return False
    
    # Calculate expected sum of elements with at most two digits from first k elements
    # At most two digits means -99 <= x <= 99 (absolute value <= 99)
    expected_sum = sum(x for x in arr[:k] if -99 <= x <= 99)
    
    if output != expected_sum:
        return False
    
    return True

def _impl(arr, k):
    """Given a non-empty array of integers arr and an integer k, return
    the sum of the elements with at most two digits from the first k elements of arr.

    Example:

        Input: arr = [111,21,3,4000,5,6,7,8,9], k = 4
        Output: 24 # sum of 21 + 3

    Constraints:
        1. 1 <= len(arr) <= 100
        2. 1 <= k <= len(arr)"""
    def digits(x: int) -> int:
        s = str(x)
        return len(s) - 1 if s[0] == "-" else len(s)
    return sum(filter(lambda x: digits(x) <= 2, arr[:k]))

def add_elements(arr, k):
    _input = (arr, k)
    assert precondition(_input)
    _output = _impl(arr, k)
    assert postcondition(_input, _output)
    return _output
