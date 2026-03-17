
def precondition(inp):
    if not isinstance(inp, tuple) or len(inp) != 1:
        return False
    arr = inp[0]
    if not isinstance(arr, list):
        return False
    if not all(isinstance(x, int) and not isinstance(x, bool) and x >= 0 for x in arr):
        return False
    return True

def postcondition(inp, out):
    arr = inp[0]
    if not isinstance(out, list):
        return False
    if sorted(out) != sorted(arr):
        return False
    for i in range(len(out) - 1):
        c1 = bin(out[i]).count('1')
        c2 = bin(out[i+1]).count('1')
        if c1 > c2:
            return False
        if c1 == c2 and out[i] > out[i+1]:
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
