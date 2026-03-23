def count_diffs(l1, l2):
    res = 0
    for x, y in zip(l1, l2):
        if x != y:
            res += 1
    return res

def smallest_change_spec(arr, cnt):
    half_len = len(arr) // 2
    prefix = arr[:half_len]
    suffix_reversed = arr[::-1][:half_len]
    return cnt == count_diffs(prefix, suffix_reversed)

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
