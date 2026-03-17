
def precondition(input):
    if len(input) != 1:
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
    arr = input[0]
    
    # Output must be a list
    if not isinstance(output, (list, tuple)):
        return False
    
    # Output must have the same length
    if len(output) != len(arr):
        return False
    
    # Output must be a permutation of input
    if sorted(output) != sorted(arr):
        return False
    
    # Check sorting: ascending by number of ones, then by decimal value
    for i in range(len(output) - 1):
        ones_i = bin(output[i]).count('1')
        ones_next = bin(output[i + 1]).count('1')
        if ones_i > ones_next:
            return False
        if ones_i == ones_next and output[i] > output[i + 1]:
            return False
    
    return True

def _impl(arr):
    """In this Kata, you have to sort an array of non-negative integers according to
    number of ones in their binary representation in ascending order.
    For similar number of ones, sort based on decimal value.

    It must be implemented like this:"""
    from functools import cmp_to_key
    def cmp(x: int, y: int) -> int:
        x1 = len(list(filter(lambda ch: ch == "1", bin(x))))
        y1 = len(list(filter(lambda ch: ch == "1", bin(y))))
        if x1 != y1: return x1 - y1
        return x - y
    return sorted(arr, key=cmp_to_key(cmp))

def sort_array(arr):
    _input = (arr,)
    assert precondition(_input)
    _output = _impl(arr)
    assert postcondition(_input, _output)
    return _output
