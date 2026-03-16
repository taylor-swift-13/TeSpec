
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    arr = input[0]
    if not hasattr(arr, "__iter__") or not hasattr(arr, "__len__"):
        return False
    try:
        for x in arr:
            if not isinstance(x, int):
                return False
            if x < 0:
                return False
    except Exception:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    arr = input[0]
    if not hasattr(output, "__iter__") or not hasattr(output, "__len__"):
        return False
    try:
        if len(output) != len(arr):
            return False
    except Exception:
        return False
    # Check permutation
    counts_in = {}
    for x in arr:
        counts_in[x] = counts_in.get(x, 0) + 1
    counts_out = {}
    try:
        for y in output:
            counts_out[y] = counts_out.get(y, 0) + 1
    except Exception:
        return False
    if counts_in != counts_out:
        return False
    # Check sorting by number of ones in binary, then by value
    def ones(n):
        return bin(n).count("1")
    it = iter(output)
    try:
        prev = next(it)
    except StopIteration:
        return True
    prev_key = (ones(prev), prev)
    for curr in it:
        curr_key = (ones(curr), curr)
        if prev_key > curr_key:
            return False
        prev_key = curr_key
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
