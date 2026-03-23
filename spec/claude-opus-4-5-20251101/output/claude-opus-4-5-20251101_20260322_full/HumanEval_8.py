from typing import List, Tuple

def sum_list(numbers):
    return sum(numbers)

def product_list(numbers):
    p = 1
    for n in numbers:
        p *= n
    return p

def sum_product_spec(numbers, result):
    return result[0] == sum_list(numbers) and result[1] == product_list(numbers)

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
