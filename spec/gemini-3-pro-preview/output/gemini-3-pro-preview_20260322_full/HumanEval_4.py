from typing import List

import math

def sum_R(l):
    res = 0.0
    for x in l:
        res += x
    return res

def mean_absolute_deviation_spec(numbers, result):
    length = len(numbers)
    
    def coq_div(x, y):
        if y == 0:
            return 0.0
        return x / y

    mean = coq_div(sum_R(numbers), length)
    diffs = [abs(x - mean) for x in numbers]
    expected = coq_div(sum_R(diffs), length)
    
    return math.isclose(result, expected, rel_tol=1e-9, abs_tol=1e-9)

def _impl(numbers: List[float]) -> float:
    mean = sum(numbers) / len(numbers)
    return sum(abs(x - mean) for x in numbers) / len(numbers)

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(mean_absolute_deviation_spec(*input, output))

def mean_absolute_deviation(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
