
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    try:
        for x in arr:
            if not isinstance(x, int):
                return False
            if x < 0:
                return False
    except TypeError:
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(arr):
        return False
    from collections import Counter
    if Counter(arr) != Counter(output):
        return False

    def ones(n):
        return bin(n).count('1')
    def key(x):
        return (ones(x), x)

    last = None
    for y in output:
        if not isinstance(y, int) or y < 0:
            return False
        k = key(y)
        if last is not None and k < last:
            return False
        last = k
    return True

def _impl(arr):
    """
    In this Kata, you have to sort an array of non-negative integers according to
    number of ones in their binary representation in ascending order.
    For similar number of ones, sort based on decimal value.

    It must be implemented like this:
    """
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
