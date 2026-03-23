def problem_120_pre(arr, k):
    if not (1 <= len(arr) <= 1000):
        return False
    if not all(-1000 <= z <= 1000 for z in arr):
        return False
    if not (0 <= k <= len(arr)):
        return False
    return True

def problem_120_spec(arr, k, res):
    if len(res) != k:
        return False
    if res != sorted(res):
        return False
    
    expected_res = sorted(arr)[len(arr) - k:] if k > 0 else []
    return res == expected_res

def _impl(arr, k):
    return sorted(sorted(arr)[::-1][:k])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_120_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_120_spec(*input, output))

def maximum(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
