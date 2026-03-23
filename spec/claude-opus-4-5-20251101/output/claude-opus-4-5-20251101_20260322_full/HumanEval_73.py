def is_palindrome(arr):
    return arr == arr[::-1]

def count_mismatches(l1, l2, n):
    mismatches = 0
    for i in range(min(n, len(l1), len(l2))):
        if l1[i] != l2[i]:
            mismatches += 1
    return mismatches

def smallest_change_spec(arr, result):
    arr_reversed = arr[::-1]
    half_len = len(arr) // 2
    return result == count_mismatches(arr, arr_reversed, half_len)

def _impl(arr):
    arr_reversed, cnt = arr[::-1], 0
    for i in range(len(arr) // 2):
        if arr[i] != arr_reversed[i]:
            cnt += 1
    return cnt

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(smallest_change_spec(*input, output))

def smallest_change(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
