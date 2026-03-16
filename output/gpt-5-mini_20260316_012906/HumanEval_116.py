
from collections import Counter

def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not isinstance(arr, (list, tuple)):
        return False
    for x in arr:
        # must be integer and non-negative
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    out = output
    if not isinstance(arr, (list, tuple)):
        return False
    if not isinstance(out, (list, tuple)):
        return False
    if len(arr) != len(out):
        return False
    # All output elements must be non-negative integers
    for x in out:
        if not isinstance(x, int):
            return False
        if x < 0:
            return False
    # Multiset equality
    if Counter(arr) != Counter(out):
        return False
    # Check ordering: sorted by number of ones in binary representation,
    # ties broken by numeric value ascending
    def ones(n):
        return bin(n).count('1')
    for i in range(len(out) - 1):
        a = out[i]
        b = out[i + 1]
        oa = ones(a)
        ob = ones(b)
        if oa > ob:
            return False
        if oa == ob and a > b:
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
