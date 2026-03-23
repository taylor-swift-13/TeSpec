def nth_Z(l, n, default):
    if n < 0 or n >= len(l):
        return default
    return l[n]

def is_valid_index(arr, i):
    return (i > 0) and (i < len(arr)) and (nth_Z(arr, i, 0) < nth_Z(arr, i - 1, 0))

def no_larger_valid_index(arr, i):
    for j in range(i + 1, len(arr)):
        if not (nth_Z(arr, j, 0) >= nth_Z(arr, j - 1, 0)):
            return False
    return True

def no_valid_index(arr):
    for i in range(1, len(arr)):
        if not (nth_Z(arr, i, 0) >= nth_Z(arr, i - 1, 0)):
            return False
    return True

def can_arrange_spec(arr, result):
    if result == -1:
        return no_valid_index(arr)
    elif result >= 0:
        i = int(result)
        return is_valid_index(arr, i) and no_larger_valid_index(arr, i)
    else:
        return False

def _impl(arr):
    for i in range(len(arr) - 1, 0, -1):
        if not (arr[i] >= arr[i - 1]):
            return i
    return -1

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(can_arrange_spec(*input, output))

def can_arrange(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
