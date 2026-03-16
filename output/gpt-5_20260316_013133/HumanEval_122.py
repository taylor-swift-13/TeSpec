
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    arr, k = input
    # Check arr supports len and slicing
    try:
        n = len(arr)
        _ = arr[:0]
    except Exception:
        return False
    if n < 1:
        return False
    # Elements must be integers
    try:
        for x in arr:
            if not isinstance(x, int):
                return False
    except Exception:
        return False
    # k must be an integer within [1, len(arr)]
    if not isinstance(k, int):
        return False
    if not (1 <= k <= n):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    arr, k = input
    expected = sum(x for x in arr[:k] if -99 <= x <= 99)
    return isinstance(output, int) and output == expected

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
