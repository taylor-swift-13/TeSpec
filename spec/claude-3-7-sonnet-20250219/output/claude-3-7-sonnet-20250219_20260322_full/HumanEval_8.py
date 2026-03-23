from typing import List, Tuple

def sum_product_spec(numbers, result_sum, result_product):
    s = 0
    p = 1
    for n in numbers:
        s += n
        p *= n
    return result_sum == s and result_product == p

def _impl(numbers: List[int]) -> Tuple[int, int]:
    s, p = 0, 1
    for number in numbers:
        s += number
        p *= number
    return s, p

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sum_product_spec(*input, output))

def sum_product(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
