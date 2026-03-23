from typing import List, Tuple

def prefix_max(l):
    if not l:
        return []
    x = l[0]
    xs = l[1:]
    rec = prefix_max(xs)
    if not rec:
        return [x]
    y = rec[0]
    ys = rec[1:]
    m = max(x, y)
    return [m] + ys

def rolling_max_spec(numbers, result):
    if len(result) != len(numbers):
        return False
    for i in range(len(numbers)):
        sub = numbers[:i+1]
        m = 0
        for x in sub:
            m = max(m, x)
        if result[i] != m:
            return False
    return True

def _impl(numbers: List[int]) -> List[int]:
    return [max(numbers[:(i+1)]) for i in range(len(numbers))]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(rolling_max_spec(*input, output))

def rolling_max(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
