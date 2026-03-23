def smallest_change_spec(arr, cnt):
    arr_reversed = arr[::-1]
    diff_count = 0
    for i in range(len(arr) // 2):
        if arr[i] != arr_reversed[i]:
            diff_count += 1
    return cnt == diff_count

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
