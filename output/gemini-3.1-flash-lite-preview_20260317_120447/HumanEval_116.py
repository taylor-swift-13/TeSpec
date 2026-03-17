
def precondition(input):
    arr = input[0]
    return isinstance(arr, list) and all(isinstance(x, int) and x >= 0 for x in arr)

def postcondition(input, output):
    arr = input[0]
    if not isinstance(output, list) or len(output) != len(arr):
        return False
    
    def count_ones(n):
        return bin(n).count('1')
    
    sorted_arr = sorted(arr, key=lambda x: (count_ones(x), x))
    return output == sorted_arr

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
