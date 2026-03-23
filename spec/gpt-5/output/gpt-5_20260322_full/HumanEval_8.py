from typing import List, Tuple

def sum_list(l):
    acc = 0
    for x in l:
        acc += x
    return acc

def prod_list(l):
    acc = 1
    for x in l:
        acc *= x
    return acc

def sum_product_spec(numbers, res):
    return res == (sum_list(numbers), prod_list(numbers))

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
