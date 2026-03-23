from typing import List

from typing import List

def is_list_min(l: List[float], m: float) -> bool:
    return (m in l) and all(m <= x for x in l)

def is_list_max(l: List[float], m: float) -> bool:
    return (m in l) and all(m >= x for x in l)

def problem_21_pre(input: List[float]) -> bool:
    return len(input) >= 2

def problem_21_spec(input: List[float], output: List[float]) -> bool:
    if not input:
        return False

    min_val = min(input)
    max_val = max(input)

    if not is_list_min(input, min_val):
        return False
    if not is_list_max(input, max_val):
        return False

    denom = max_val - min_val
    if denom == 0.0:
        expected = [0.0 for _ in input]
    else:
        expected = [(x - min_val) / denom for x in input]

    return output == expected

def _impl(numbers: List[float]) -> List[float]:
    ma, mi = max(numbers), min(numbers)
    k = 1 / (ma - mi)
    return list(map(lambda x: (x - mi) * k, numbers))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_21_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_21_spec(*input, output))

def rescale_to_unit(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
