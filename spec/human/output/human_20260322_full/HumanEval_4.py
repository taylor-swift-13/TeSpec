from typing import List

import math

def problem_4_pre(l):
    return len(l) > 0

def problem_4_spec(l, mad):
    n = len(l)
    if n == 0:
        mu = 0.0
        expected_mad = 0.0
    else:
        mu = sum(l) / n
        expected_mad = sum(abs(x - mu) for x in l) / n
        
    return math.isclose(mad, expected_mad, rel_tol=1e-5, abs_tol=1e-8)

def _impl(numbers: List[float]) -> float:
    mean = sum(numbers) / len(numbers)
    return sum(abs(x - mean) for x in numbers) / len(numbers)

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_4_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_4_spec(*input, output))

def mean_absolute_deviation(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
