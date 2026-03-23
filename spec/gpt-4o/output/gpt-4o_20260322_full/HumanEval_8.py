from typing import List, Tuple

def sum_product_spec(numbers, result):
    sum_val = 0
    product_val = 1
    for n in numbers:
        sum_val += n
        product_val *= n
    return result == (sum_val, product_val)

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
