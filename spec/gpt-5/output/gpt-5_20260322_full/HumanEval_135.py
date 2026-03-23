def can_arrange_spec(arr, res):
    n = len(arr)
    if res == -1:
        for i in range(1, n):
            if arr[i] < arr[i - 1]:
                return False
        return True
    elif 1 <= res <= n - 1:
        if arr[res] >= arr[res - 1]:
            return False
        for j in range(res + 1, n):
            if arr[j] < arr[j - 1]:
                return False
        return True
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
