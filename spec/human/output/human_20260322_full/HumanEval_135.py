def drop_at(lst, k):
    if 1 <= k < len(lst):
        return lst[k] < lst[k - 1]
    return False

def problem_135_pre(lst):
    return len(lst) == len(set(lst))

def problem_135_spec(lst, r):
    max_k = -1
    for k in range(1, len(lst)):
        if drop_at(lst, k):
            max_k = k
    return r == max_k

def _impl(arr):
    for i in range(len(arr) - 1, 0, -1):
        if not (arr[i] >= arr[i - 1]):
            return i
    return -1

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_135_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_135_spec(*input, output))

def can_arrange(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
