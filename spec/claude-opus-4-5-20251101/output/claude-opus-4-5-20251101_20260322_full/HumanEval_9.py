from typing import List, Tuple

def max_list(l, default):
    if not l:
        return default
    return max(l)

def firstn(n, l):
    return l[:n]

def rolling_max_aux(numbers, idx):
    res = []
    for i in range(1, idx + 1):
        res.append(max_list(firstn(i, numbers), 0))
    return res

def rolling_max(numbers):
    return rolling_max_aux(numbers, len(numbers))

def rolling_max_spec(numbers, result):
    if len(result) != len(numbers):
        return False
    for i in range(len(numbers)):
        if result[i] != max_list(firstn(i + 1, numbers), 0):
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
