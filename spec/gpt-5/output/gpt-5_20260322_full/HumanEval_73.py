def smallest_change_spec(arr, res):
    half = len(arr) // 2
    first = arr[:half]
    rfirst = list(reversed(arr))[:half]
    
    mismatches = sum(1 for p1, p2 in zip(first, rfirst) if p1 != p2)
    return res == mismatches

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
