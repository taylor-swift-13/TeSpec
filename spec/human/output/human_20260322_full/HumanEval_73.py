def count_diff(l1, l2, acc):
    for x, y in zip(l1, l2):
        if x != y:
            acc += 1
    return acc

def smallest_change_impl(arr):
    length = len(arr)
    half_len = length // 2
    first_half = arr[:half_len]
    second_half = arr[length - half_len:]
    return count_diff(first_half, list(reversed(second_half)), 0)

def problem_73_pre(arr):
    return True

def problem_73_spec(arr, n):
    return n == smallest_change_impl(arr)

def _impl(arr):
    arr_reversed, cnt = arr[::-1], 0
    for i in range(len(arr) // 2):
        if arr[i] != arr_reversed[i]:
            cnt += 1
    return cnt

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_73_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_73_spec(*input, output))

def smallest_change(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
