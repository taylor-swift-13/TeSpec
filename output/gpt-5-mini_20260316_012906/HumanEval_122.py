
from collections.abc import Sequence

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 2:
        return False
    arr, k = input
    # arr must be a non-string sequence (like list/tuple)
    if not isinstance(arr, Sequence) or isinstance(arr, (str, bytes)):
        return False
    try:
        n = len(arr)
    except Exception:
        return False
    if not (isinstance(n, int) and 1 <= n <= 100):
        return False
    if not isinstance(k, int):
        return False
    if not (1 <= k <= n):
        return False
    # all elements must be integers (exclude bool)
    for x in arr:
        if not isinstance(x, int) or isinstance(x, bool):
            return False
    return True

def postcondition(input, output):
    # Only enforce when precondition holds
    if not precondition(input):
        return True
    arr, k = input
    expected = 0
    for x in arr[:k]:
        # consider at most two decimal digits (ignore sign): abs(x) <= 99
        if isinstance(x, int) and not isinstance(x, bool) and abs(x) <= 99:
            expected += x
    if not isinstance(output, int) or isinstance(output, bool):
        return False
    return output == expected

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
