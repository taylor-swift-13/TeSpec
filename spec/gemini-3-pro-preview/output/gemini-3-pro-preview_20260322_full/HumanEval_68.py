def pluck_spec(arr, res):
    evens = [(x, i) for i, x in enumerate(arr) if x % 2 == 0]
    if not evens:
        expected = []
    else:
        v, i = min(evens, key=lambda pair: (pair[0], pair[1]))
        expected = [v, i]
    return res == expected

def _impl(arr):
    if all(val % 2 == 1 for val in arr): return []
    min_even = min(filter(lambda x: x % 2 == 0, arr))
    for i in range(len(arr)):
        if arr[i] == min_even:
            return [min_even, i]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(pluck_spec(*input, output))

def pluck(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
