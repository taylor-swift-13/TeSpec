
def precondition(input):
    if len(input) != 2:
        return False
    arr, k = input
    if not isinstance(arr, list):
        return False
    if not isinstance(k, int):
        return False
    if len(arr) < 1 or len(arr) > 100:
        return False
    if k < 1 or k > len(arr):
        return False
    if not all(isinstance(x, int) for x in arr):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, int):
        return False
    arr, k = input
    expected = sum(x for x in arr[:k] if -99 <= x <= 99)
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
