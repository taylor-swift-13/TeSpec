from typing import List, Tuple

def max_prefix_at(numbers, i):
    prefix = numbers[:i+1]
    if not prefix:
        return None
    return max(prefix)

def rolling_max_spec(numbers, result):
    if len(result) != len(numbers):
        return False
    for i in range(len(numbers)):
        if result[i] != max_prefix_at(numbers, i):
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
