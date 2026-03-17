
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    arr = input_args[0]
    return isinstance(arr, list) and all(isinstance(x, int) and x >= 0 for x in arr)

def postcondition(input_args, output):
    arr = input_args[0]
    if not isinstance(output, list) or len(arr) != len(output):
        return False
    
    if sorted(arr) != sorted(output):
        return False
    
    for i in range(len(output) - 1):
        val1 = output[i]
        val2 = output[i+1]
        ones1 = bin(val1).count('1')
        ones2 = bin(val2).count('1')
        
        if ones1 > ones2:
            return False
        if ones1 == ones2 and val1 > val2:
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
